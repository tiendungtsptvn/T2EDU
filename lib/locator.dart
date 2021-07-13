import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/config/config.dart';
import 'package:t4edu_source_source/data/repository/account_repository.dart';
import 'package:t4edu_source_source/global/app_navigation.dart';
import 'package:t4edu_source_source/source/api/client/rest/auth_client.dart';
import 'package:t4edu_source_source/source/api/client/rest/rest_client.dart';
import 'package:t4edu_source_source/source/api/interceptors.dart';
import 'package:t4edu_source_source/source/local/pref.dart';
void setupLocator(){
  GetIt.I.registerLazySingleton(() => Navigation());

  GetIt.I.registerSingleton<AppConfig>(
    AppConfig(),
  );

  GetIt.I.registerLazySingleton<Pref>(
        () => Pref(),
  );

  GetIt.I.registerLazySingleton<RestClient>(
        () => RestClient(
      GetIt.I<AppConfig>().baseUrl,
      <Interceptor>[
        SessionInterceptor(),
        LoggingInterceptor(),
      ],
    ),
  );

  GetIt.I.registerLazySingleton<ClientAuth>(
        () => ClientAuth(
      GetIt.I<AppConfig>().authUrl,
      <Interceptor>[
        SessionInterceptor(),
        LoggingInterceptor(),
      ],
    ),
  );

  GetIt.I.registerSingleton<AuthRepositoryIml>(
    AuthRepositoryIml(GetIt.I<ClientAuth>()),
  );
}
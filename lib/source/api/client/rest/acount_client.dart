import 'package:dio/dio.dart';
import 'package:t4edu_source_source/source/api/client/rest_client.dart';

class AccountClient extends RestClientBase {
  AccountClient(String baseUrl, List<Interceptor> interceptors)
      : super(baseUrl, interceptors);
}
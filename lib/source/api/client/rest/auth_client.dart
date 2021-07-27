import 'package:dio/dio.dart';
import 'package:t4edu_source_source/source/api/client/rest_client_base.dart';

class ClientAuth extends RestClientBase {
  ClientAuth(String authUrl, List<Interceptor> interceptors)
      : super(authUrl, interceptors);
}
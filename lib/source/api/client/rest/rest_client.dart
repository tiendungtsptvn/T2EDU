import 'package:dio/dio.dart';
import 'package:t4edu_source_source/source/api/client/rest_client_base.dart';

class RestClient extends RestClientBase {
  RestClient(String baseUrl, List<Interceptor> interceptors)
      : super(baseUrl, interceptors);
}
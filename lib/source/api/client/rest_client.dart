import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:dio/dio.dart';
import 'package:t4edu_source_source/source/api/api_error.dart';
import 'package:t4edu_source_source/source/api/api_response.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';

import '../interceptors.dart';

class RestClientBase {
  static const Duration defaultTimeout = Duration(seconds: 15);
  static const String formUrlEncodedContentType =
      'application/json;charset=UTF-8';

  RestClientBase(
    String baseUrl,
    List<Interceptor> interceptors, {
    Duration timeout = defaultTimeout,
  }) {
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: timeout.inMilliseconds,
      receiveTimeout: timeout.inMilliseconds,
      contentType: formUrlEncodedContentType,
      responseType: ResponseType.json,
    );

    _dio = Dio(options);
    final CookieJar cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));
    _dio.interceptors.addAll(interceptors ?? <Interceptor>[]);
    _dio.interceptors.add(RefreshTokenInterceptor(_dio));

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Dio _dio;

  Future<dynamic> get(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      ApiResponse res = _mapResponse(response.data);

      return res.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> patch(String path,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress}) async {
    try {
      final Response<dynamic> response = await _dio.patch<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      ApiResponse res = _mapResponse(response.data);

      return res.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> put(String path,
      {dynamic data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress}) async {
    try {
      final Response<dynamic> response = await _dio.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      ApiResponse res = _mapResponse(response.data);

      return res.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> delete(String path,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken}) async {
    try {
      final Response<dynamic> response = await _dio.delete<dynamic>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);

      ApiResponse res = _mapResponse(response.data);

      return res.data;
    } catch (e) {
      print("*******************Exception_START*******************");
      print(e);
      print("*******************Exception_END*******************");
      throw _mapError(e);
    }
  }

  ApiError _mapError(dynamic e) {
    if (e is DioError) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          return ApiError(
              errorCode: 'CONNECT_TIMEOUT',
              message: '${LocaleKeys.error_message_default.tr()} (timeout)');
        case DioErrorType.sendTimeout:
          return ApiError(
              errorCode: 'SEND_TIMEOUT',
              message:
                  '${LocaleKeys.error_message_default.tr()} (send timeout)');
        case DioErrorType.receiveTimeout:
          return ApiError(
              errorCode: 'RECEIVE_TIMEOUT',
              message:
                  '${LocaleKeys.error_message_default.tr()} (receive timeout)');
        case DioErrorType.cancel:
          return ApiError(
              errorCode: 'CANCEL',
              message: '${LocaleKeys.error_message_default.tr()} (cancel)');
        case DioErrorType.other:
          String mms = e?.message;

          // https://github.com/flutterchina/dio/issues/817
          if (mms != null && mms.contains("Future<dynamic>")) {
            return ApiError(errorCode: 'DEFAULT', message: "ERROR_IGNORE");
          }

          return ApiError(
            errorCode: 'DEFAULT',
            message: LocaleKeys.error_message_default.tr(),
          );
        case DioErrorType.response:
          String code =
              ((e?.response?.statusCode.toString())).replaceAll("-", "_");

          // Bắt riêng lỗi 500 - Internal Server Error
          if (code == '500' ||
              code == '501' ||
              code == '502' ||
              code == '503') {
            return ApiError(
                errorCode: code,
                message: LocaleKeys.error_message_default.tr());
          }

          String msg = "ERR$code".tr();

          if (e?.response?.data != null && e?.response?.data is Map) {
            try {
              dynamic errorData = e.response.data;
              code =
                  (errorData['errorCode']?.toString() ?? code).replaceAll("-", "_");

              msg = "ERR$code".tr();

              if (msg.startsWith("ERR")) {
                msg = errorData["message"];
              }
              //Nếu msg null or empty thì ném cái lỗi mặc định ra
              if (msg == null || msg.isEmpty) {
                msg = LocaleKeys.something_error.tr();
              }
            } catch (error) {
              print(error);
            } finally {
              print(e?.response?.data.toString() ?? code);
            }
          }

          return ApiError(
            errorCode: code,
            message: msg,
          );
      }
    }

    return ApiError();
  }

  ApiResponse _mapResponse(dynamic response) {
    if (response is String) {
      response = jsonDecode(response);
    }

    return ApiResponse.fromJson(response);
  }
}

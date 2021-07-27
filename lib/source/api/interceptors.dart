import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:t4edu_source_source/domain/models/access_token.dart';
import 'package:t4edu_source_source/global/app_const.dart';
import 'package:t4edu_source_source/global/app_toast.dart';
import 'package:t4edu_source_source/instance/Session.dart';
import 'package:t4edu_source_source/source/api/api_error.dart';
import 'package:t4edu_source_source/source/local/pref.dart';
import 'package:uuid/uuid.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!kReleaseMode) {
      print(
          '********************************** START **********************************');
      print('---> ${options.method} ${options.baseUrl}${options.path}');
      if (options.method == "GET") {
        print(options.queryParameters);
      }
      options.headers
          .forEach((String k, dynamic v) => print('$k: ${v?.toString()}'));
      print(options.data);
    }
    return handler.next(options);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (!kReleaseMode) {
      print(
          '<--- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      response.headers
          .forEach((String k, dynamic v) => print('$k: ${v?.toString()}'));
      if (response.data is Map || response.data is List) {
        print(jsonEncode(response.data));
      } else {
        print(response.data);
      }
      print(
          '********************************** END-SUCCESS **********************************');
    }
    return handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (!kReleaseMode) {
      print(
          '********************************** END-ERROR **********************************');
    }
    return handler.next(err);
  }
}

class SessionInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String accessToken = Session.instance().accessToken;
    if (accessToken != null) {
      options.headers.addAll(<String, dynamic>{
        'Authorization': "Bearer " + accessToken,
        'X-Request-ID': Uuid().v1(),
      });
    } else {
      options.headers.addAll(<String, dynamic>{
        'Authorization': "",
        'X-Request-ID': Uuid().v1(),
      });
    }
    return handler.next(options);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (!kReleaseMode) {
      print('SessionInterceptor onError: ');
      print(err.message);
    }
    return handler.next(err);
  }
}

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor(this.dio);

  final Dio dio;

  Future<AccessTokens> refreshToken() async {
    String path = "http://35.240.198.195:8080/api/author/auth/refresh-token";
    var response = await Dio().post(path, data: <String, dynamic>{
      'refreshToken': Session.instance().refreshToken
    });

    if (response.data is Map) {
      var accessToken =
          AccessTokens.fromJson(response.data["data"] as Map<String, dynamic>);

      if (accessToken != null) {
        Session.instance().setAccessToken(accessToken.accessToken);
        Pref().putString(AppConst.accessToken, accessToken.accessToken);
      }
      return accessToken;
    }
    AppToast.showError("Đã xảy ra lỗi! Quý khách vui lòng thử lại sau");
    return null;
  }

  @override
  Future onError(DioError error, ErrorInterceptorHandler handler) async {
    if (error?.response?.statusCode == 401 &&
        !error.requestOptions.path.contains('login')) {
      if (error.requestOptions.path.contains('refresh')) {
        return error;
      }

      String accessToken = "Bearer " + Session.instance().accessToken;
      RequestOptions optionRequest = error.response.requestOptions;

      var options = error.response.requestOptions;

      if (accessToken != optionRequest.headers["Authorization"]) {
        options.headers["Authorization"] = accessToken;

        dio.fetch(options).then(
              (r) => handler.resolve(r),
          onError: (e) {
            handler.reject(e);
          },
        );
        return;
      }

      dio.lock();
      dio.interceptors.responseLock.lock();
      dio.interceptors.errorLock.lock();

      await refreshToken().then((d) {
        //update accessToken
        options.headers["Authorization"] = accessToken = d.accessToken;
        print(options.headers);
      }).whenComplete(() {
        dio.unlock();
        dio.interceptors.responseLock.unlock();
        dio.interceptors.errorLock.unlock();
      }).catchError((e) {
        // Handle refreshToken error, check if 400 then emit session expired.
        final bool is400 = (e is ApiError && e.code == '400') ||
            (e is DioError && e.response?.statusCode == 400);

        if (is400) {
          dio.clear();
          Future.delayed(Duration.zero, () {
            // Delay 250 milliseconds to schedule call to next event loop queue
            Session.instance().expired();
            Pref().clear();
          });
        }

        throw e;
      }).then((e) {
        dio.fetch(options).then(
              (r) => handler.resolve(r),
          onError: (e) {
            handler.reject(e);
          },
        );
      });
      return;
    }
    return handler.next(error);
  }
}

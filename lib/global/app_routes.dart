import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t4edu_source_source/page/forgot_password/confirm_otp.dart';
import 'package:t4edu_source_source/page/forgot_password/forgot_password.dart';
import 'package:t4edu_source_source/page/forgot_password/reset_password.dart';
import 'package:t4edu_source_source/page/forgot_password/reset_success.dart';
import 'package:t4edu_source_source/page/login/login.dart';
import 'package:t4edu_source_source/page/main/main_page.dart';
import 'package:t4edu_source_source/page/splash/splash.dart';

class AppRouter {
  AppRouter._();

  static MaterialPageRoute<Widget> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<Widget>(
      builder: (BuildContext context) => makeRoute(
          context: context,
          routeName: settings.name,
          arguments: settings.arguments),
    );
  }

  static Widget makeRoute(
      {@required BuildContext context,
      @required String routeName,
      Object arguments}) {
    switch (routeName) {
      case splash:
        return SplashScreen();
      case mainPage:
        return MainPage();
      case login:
        return LoginPage();
      case forgotPassword:
        return ForgotPasswordPage();
      case confirmOTPForPass:
        return ConfirmOTPPage(username: arguments);
      case resetPassword:
        return ResetPasswordPage(token: arguments);
      case resetSuccess:
        return ResetSuccessPage();

      default:
        throw 'Route $routeName is not defined';
    }
  }

  static const String mainPage = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String confirmOTPForPass = '/confirmOTP';
  static const String resetPassword = '/resetPassword';
  static const String resetSuccess = '/resetSuccess';
}

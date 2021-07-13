import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        return Login();
      default:
        throw 'Route $routeName is not defined';
    }
  }

  static const String mainPage = '/';
  static const String splash = '/splash';
  static const String login = '/login';
}

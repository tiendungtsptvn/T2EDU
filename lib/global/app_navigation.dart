import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/base/widget/bubu_dialog.dart';
import 'package:t4edu_source_source/global/app_routes.dart';
import 'package:t4edu_source_source/instance/app_index.dart';
import 'package:t4edu_source_source/instance/connection.dart';

class Navigation {
  Widget _dialogContent;
  String _fromScreen;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool closing = false;

  Future<dynamic> pushNamed(String routeName, {Object arguments}) {

    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }


  Future<dynamic> pushNamedAndRemoveUntil(String routeName, RoutePredicate predicate,{Object arguments} ) {

    return navigatorKey.currentState.pushNamedAndRemoveUntil(routeName, predicate);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> push(Widget widget, {bool visible = true}) {
    return navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  void pop({dynamic result}) {
    navigatorKey.currentState.pop(result);
  }

  void popUntil(bool Function(Route) predicate) {
    return navigatorKey.currentState.popUntil(predicate);
  }

  void popToFirst() {
    if (ConnectionStateProvider.instance().notInternet) {
      return;
    }

    if (navigatorKey.currentContext == null) {
      return;
    }

    Navigator.of(navigatorKey.currentContext)
        .popUntil((route) => route.isFirst);

    AppIndex.instance().updateIndex(0);
  }

  void popWithInternet() {
    final context = navigatorKey?.currentState?.context;

    if (context == null) {
      return;
    }

    _fromScreen == AppRouter.splash ? popToFirst() : close();
  }

  void showNoInternet({String from, bool hasConnection = true}) {
    _fromScreen = from;

    final context = navigatorKey?.currentState?.context;

    if (context == null) {
      return;
    }

    // _dialogContent = NoInternet(
    //   onPress: popToFirst,
    // );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => _dialogContent,
    );
  }

  void close() {
    if (closing || (_fromScreen != null && _fromScreen == AppRouter.splash)) {
      return;
    }

    closing = true;

    if (_dialogContent != null) {
      _dialogContent = null;
      Navigator.of(navigatorKey.currentContext).pop();
    }

    closing = false;
  }

  void showLogin() {
    final context = navigatorKey.currentState.overlay.context;
    if (_dialogContent != null) {
      return;
    }
    _dialogContent = BuBuAlertDialog(
      title: 'Phiên đăng nhập hết hạn',
      des: 'Bạn phải đăng nhập lại để tiếp tục sử dụng app',
      accept: () {
        GetIt.I<Navigation>().pop();
        // GetIt.I<Navigation>().pushNamed(AppRouter.login);
      },
      actionCancel: (){
        GetIt.I<Navigation>().pop();
      },
      cancelText: 'Không',
      acceptText: 'Đồng ý',
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => _dialogContent,
    );
  }
}

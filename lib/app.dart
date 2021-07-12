import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:t4edu_source_source/base/widget/footer_loadling.dart';
import 'package:t4edu_source_source/global/app_const.dart';
import 'package:t4edu_source_source/global/app_navigation.dart';
import 'package:t4edu_source_source/global/app_routes.dart';
import 'package:t4edu_source_source/instance/Session.dart';
import 'package:t4edu_source_source/instance/app_index.dart';
import 'package:t4edu_source_source/instance/connection.dart';
import 'package:t4edu_source_source/source/local/pref.dart';
import 'base/widget/header_refresh.dart';
import 'global/app_local.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _streamConnectivity;
  bool hasConnect = false;

  @override
  void initState() {
    super.initState();
    _autoLogin();
    WidgetsBinding.instance.addObserver(this);


    Session.instance().addListener(_sessionChanged);
    initConnectivity();
    _initLocal();
    _streamConnectivity =
        Connectivity().onConnectivityChanged.listen(_connectionChange);
  }

  void _autoLogin() async {
    String accessToken = await Pref().getString(AppConst.accessToken);
    if (accessToken != null) {
      Session.instance().setAccessToken(accessToken);
      String refreshToken = await Pref().getString(AppConst.refreshToken);
      Session.instance().setRefreshToken(refreshToken);
    }
  }

  void _sessionChanged() {
    if (Session.instance().state == SessionState.expired) {
      //
      Session.instance().reInit(shouldNotify: false);
      // Do redirect
      SchedulerBinding.instance.addPostFrameCallback(
            (timeStamp) {
          final Navigation navigation = GetIt.I<Navigation>();

          navigation.popToFirst();
          navigation.showLogin();
        },
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    super.didChangeAppLifecycleState(appLifecycleState);
    if (appLifecycleState == AppLifecycleState.resumed) {
      initConnectivity();
    }
  }

  @override
  void dispose() {
    _streamConnectivity.cancel();
    Session.instance().removeListener(_sessionChanged);
    super.dispose();
  }

  void _initLocal() async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      // Lấy langugae user đã lưu
      Language.initLanguage(context);
      // Check lần đầu mở app
      bool hasInit =
      await Pref().getBool(AppConst.initLanguage, defaultValue: false);
      // Đã init rồi thì thôi
      if (hasInit) {
        return;
      }
      String defaultLocaleDevice = Platform.localeName;

      if (defaultLocaleDevice != null && defaultLocaleDevice.length >= 2) {
        if ("vi" == defaultLocaleDevice.substring(0, 2)) {
          Language.saveLang(Language.VN);
          // ignore: deprecated_member_use
          context.locale = Locale(Language.VN.languageCode, '');
        }
        await Pref().putBool(AppConst.initLanguage, true);
      }
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _connectionChange(result);
  }

  Future<void> _connectionChange(ConnectivityResult result) async {
    bool newState = result != ConnectivityResult.none;

    if (newState == ConnectionStateProvider.instance().state) {
      return;
    }

    ConnectionStateProvider.instance().update(newState);

    try {
      hasConnect = await DataConnectionChecker().hasConnection;
    } catch (error) {
      print(error);
    }

    if (hasConnect) {
      GetIt.I<Navigation>().popWithInternet();
    } else {
      // Mobile/wifi data detected but no internet connection found.
      GetIt.I<Navigation>().showNoInternet(hasConnection: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppIndex.instance()),
        ChangeNotifierProvider.value(value: Session.instance()),
      ],
      child: RefreshConfiguration(
        footerTriggerDistance: 15,
        headerTriggerDistance: 20,
        dragSpeedRatio: 0.5,
        headerBuilder: () => HeaderRefresh(),
        footerBuilder: () => FooterLoad(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: GetIt.I<Navigation>().navigatorKey,
          navigatorObservers: [routeObserver],
          onGenerateRoute: AppRouter.onGenerateRoute,
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          initialRoute: AppRouter.splash,
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child,
            );
          },
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

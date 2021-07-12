import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t4edu_source_source/app.dart';
import 'package:t4edu_source_source/global/app_local.dart';
import 'package:t4edu_source_source/translations/codegen_loader.g.dart';
import 'locator.dart';



Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runZonedGuarded(() {
    runApp(EasyLocalization(
      supportedLocales: Language.supportedLocales,
      path: 'assets/translations',
      assetLoader: CodegenLoader(),
      fallbackLocale: Locale('vi', ''),
      startLocale: Locale('vi', ''),
      child: MyApp(),
    ));
  }, (error, stackTrace) {
    print(error);
  });
}

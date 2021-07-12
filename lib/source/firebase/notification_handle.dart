// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get_it/get_it.dart';
// import 'package:t4edu_source/global/app_navigation.dart';
// import 'package:t4edu_source/global/app_routes.dart';
//
// class NotificationHandler {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   static BuildContext myContext;
//
//   static void initNotification(BuildContext context) {
//     myContext = context;
//
//     AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );
//
//     InitializationSettings initializationSetting = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//
//     flutterLocalNotificationsPlugin.initialize(initializationSetting,
//         onSelectNotification: onSelectNotification
//     );
//   }
//
//   static Future onDidReceiveLocalNotification(
//       int id, String title, String body, String payLoad) {
//     print("onDidReceiveLocalNotifications");
//   }
//
//   static Future onSelectNotification(String payload) async {
//     if (payload != null) {
//       print(payload + "payloadddddd");
//       if(payload.startsWith("task")){
//         GetIt.instance<Navigation>().pushNamed(AppRouter.detailsTask,
//             arguments: int.parse(payload.split("/").last));
//       }
//     }
//   }
// }

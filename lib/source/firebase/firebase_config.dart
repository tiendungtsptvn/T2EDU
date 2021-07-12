// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get_it/get_it.dart';
// import 'package:t4edu_source/global/app_navigation.dart';
// import 'package:t4edu_source/global/app_routes.dart';
// import 'package:t4edu_source/source/firebase/notification_handle.dart';
//
// class FirebaseConfig {
//   FirebaseMessaging _firebaseMessaging;
//   BuildContext myContext;
//
//   void setupFirebase(BuildContext context) {
//     _firebaseMessaging = FirebaseMessaging.instance;
//     NotificationHandler.initNotification(context);
//     firebaseCloudMessageListener(context);
//     myContext = context;
//   }
//
//   Future<String> getToken() {
//     return _firebaseMessaging.getToken().then((value) {
//       return value;
//     });
//   }
//
//   firebaseCloudMessageListener(BuildContext context) async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//         alert: true,
//         announcement: true,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true);
//
//     _firebaseMessaging
//         .subscribeToTopic('common')
//         .whenComplete(() => print("BuJo Connect Success"));
//
//     FirebaseMessaging.onMessage.listen((remoteMessage) {
//       if (Platform.isAndroid)
//         showNotification(remoteMessage.notification.title,
//             remoteMessage.notification.body, remoteMessage.data['screen']);
//       else if (Platform.isIOS)
//         showNotification(remoteMessage.notification.title,
//             remoteMessage.notification.body, remoteMessage.data['screen']);
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       print('A new onMessageOpenedApp event was published!');
//       RemoteNotification notification = message.notification;
//       AndroidNotification android = message.notification?.android;
//     });
//
//     FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message){
//       if (message.data['screen'] != null) {
//         if(message.data['screen'].startsWith("task")){
//           GetIt.instance<Navigation>().pushNamed(AppRouter.detailsTask,
//               arguments: int.parse(message.data['screen'].split("/").last));
//         }
//       }
//     });
//   }
//
//   static void showNotification(title, body, payload) async {
//     AndroidNotificationDetails androidChannel = AndroidNotificationDetails(
//       'BUJO',
//       'BUJO_VUONFSOFT',
//       'BUJO_VUONGSOFT_DEV',
//       ongoing: true,
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     IOSNotificationDetails iosChannel = IOSNotificationDetails();
//
//     var platform =
//         NotificationDetails(android: androidChannel, iOS: iosChannel);
//
//     await NotificationHandler.flutterLocalNotificationsPlugin
//         .show(0, title, body, platform, payload: payload);
//   }
// }

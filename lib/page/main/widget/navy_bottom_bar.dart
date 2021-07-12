// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:t4edu_source_source/global/app_color.dart';
// import 'package:t4edu_source_source/global/app_path.dart';
// import 'package:t4edu_source_source/translations/locale_keys.g.dart';
//
// class TabNavigationItem {
//   const TabNavigationItem({
//     @required this.page,
//     @required this.title,
//     @required this.icon,
//   });
//
//   final Widget page;
//   final String title;
//   final Icon icon;
//
//   static List<TabNavigationItem> get items => <TabNavigationItem>[
//     TabNavigationItem(
//       // page: MarketPage(),
//       page: MyHomePage(),
//       icon: Icon(Icons.show_chart),
//       title: "Đăng việc",
//     ),
//     TabNavigationItem(
//       page: MyTasks(),
//       icon: Icon(Icons.account_balance_wallet),
//       title: "Quản lý",
//     ),
//     TabNavigationItem(
//       page: LiveTasks(),
//       icon: Icon(Icons.attach_money),
//       title: "Tìm việc",
//     ),
//     TabNavigationItem(
//       page: NoTiTab(),
//       icon: Icon(Icons.extension),
//       title: "Thông báo",
//     ),
//     TabNavigationItem(
//       page: Settings(),
//       icon: Icon(Icons.library_books),
//       title: "Mở rộng",
//     ),
//   ];
// }
//
// class TabHelper {
//   static TabItem item({int index}) {
//     switch (index) {
//       case 0:
//         return TabItem.POST_TASK;
//       case 1:
//         return TabItem.MANAGER;
//       case 2:
//         return TabItem.FIND_JOB;
//       case 3:
//         return TabItem.NOTIFICATION;
//       case 4:
//         return TabItem.MORE;
//     }
//     return TabItem.POST_TASK;
//   }
//
//   static String description(int tabItem) {
//     switch (tabItem) {
//       case 0:
//         return LocaleKeys.post_task.tr();
//       case 1:
//         return LocaleKeys.manage.tr();
//       case 2:
//         return LocaleKeys.find_job.tr();
//       case 3:
//         return LocaleKeys.notification.tr();
//       case 4:
//         return LocaleKeys.more.tr();
//     }
//     return '';
//   }
//
//   static Image iconImage(int tabItem, Color color) {
//     switch (tabItem) {
//       case 0:
//         return Image.asset(
//           AppPath.home_active,
//           color: color,
//           height: 32,
//           width: 32,
//         );
//       case 1:
//         return Image.asset(
//           AppPath.task_active,
//           color: color,
//           height: 32,
//           width: 32,
//         );
//       case 2:
//         return Image.asset(
//           AppPath.job_active,
//           color: color,
//           height: 32,
//           width: 32,
//         );
//       case 3:
//         return Image.asset(
//           AppPath.noti,
//           color: color,
//           height: 32,
//           width: 32,
//         );
//       default:
//         return Image.asset(
//           AppPath.setting_active,
//           color: color,
//           height: 32,
//           width: 32,
//         );
//     }
//   }
//
//   static Color color(TabItem tabItem) {
//     switch (tabItem) {
//       case TabItem.POST_TASK:
//         return AppColors.blueDiamond;
//       case TabItem.MANAGER:
//         return AppColors.blueDiamond;
//       case TabItem.FIND_JOB:
//         return AppColors.blueDiamond;
//       case TabItem.NOTIFICATION:
//         return AppColors.blueDiamond;
//       case TabItem.MORE:
//         return AppColors.blueDiamond;
//     }
//     return AppColors.grey;
//   }
//
//   static Color colorTabItem(int tabItem) {
//     switch (tabItem) {
//       case 0:
//         return AppColors.blueDiamond;
//       case 1:
//         return AppColors.blueDiamond;
//       case 2:
//         return AppColors.blueDiamond;
//       case 3:
//         return AppColors.blueDiamond;
//       case 4:
//         return AppColors.blueDiamond;
//     }
//     return AppColors.grey;
//   }
// }
//
// enum TabItem { POST_TASK, MANAGER, FIND_JOB, NOTIFICATION, MORE }
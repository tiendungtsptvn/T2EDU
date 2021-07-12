import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:t4edu_source_source/global/app_color.dart';
import 'package:t4edu_source_source/global/app_textStyle.dart';
import 'package:t4edu_source_source/instance/app_index.dart';
import 'package:t4edu_source_source/page/main/widget/navy_bottom_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  // PageController _pageController;
  // DateTime current;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController(initialPage: 0);
  //   _bind();
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   _pageController.dispose();
  // }
  //
  // void _bind() {
  //   AppIndex.instance().addListener(() {
  //     try {
  //       _pageController?.jumpToPage(AppIndex.instance()?.index ?? 0);
  //     } catch (_) {}
  //   });
  // }
  //
  // Future<bool> onWillPop() {
  //   DateTime now = DateTime.now();
  //   if (current == null ||  now.difference(current) > Duration(seconds: 2)) {
  //     current = now;
  //     Fluttertoast.showToast(
  //       msg: "Chạm lại để thoát",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER
  //     );
  //     return Future.value(false);
  //   } else {
  //     Fluttertoast.cancel();
  //     return Future.value(true);
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //     onWillPop: onWillPop,
  //     child: Scaffold(
  //       body: _buildPageView(),
  //       bottomNavigationBar: BottomNavigationBar(
  //         currentIndex: context.watch<AppIndex>().index,
  //         selectedFontSize: 12,
  //         unselectedFontSize: 12,
  //         type: BottomNavigationBarType.fixed,
  //         backgroundColor: AppColors.white,
  //         onTap: (int selectedIndex) {
  //           AppIndex.instance().updateIndex(selectedIndex);
  //         },
  //         items: [
  //           _buildItem(0),
  //           _buildItem(1),
  //           _buildItem(2),
  //           _buildItem(3),
  //           _buildItem(4)
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildPageView() {
  //   return PageView(
  //     controller: _pageController,
  //     physics: NeverScrollableScrollPhysics(),
  //     children: TabNavigationItem.items.map((e) => e.page).toList(),
  //   );
  // }
  //
  // BottomNavigationBarItem _buildItem(int tabIndex) {
  //   String text = TabHelper.description(tabIndex);
  //   return BottomNavigationBarItem(
  //     icon: TabHelper.iconImage(tabIndex, _colorTabMatching(index: tabIndex)),
  //     title: Text(
  //       text,
  //       textScaleFactor: 1.0,
  //       style: tabIndex == AppIndex.instance().index
  //           ? AppTextStyles.normal(
  //         fontSize: 12.0,
  //         fontWeight: FontWeight.w600,
  //         color: AppColors.blueDiamond,
  //       )
  //           : AppTextStyles.normal(
  //         fontSize: 12.0,
  //         fontWeight: FontWeight.w400,
  //         color: AppColors.grey,
  //       ),
  //     ),
  //   );
  // }
  //
  // Color _colorTabMatching({int index}) {
  //   return AppIndex.instance().index == index
  //       ? AppColors.blueDiamond
  //       : AppColors.grey;
  // }
}
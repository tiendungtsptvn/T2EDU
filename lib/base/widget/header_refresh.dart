import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:t4edu_source_source/global/app_path.dart';


class HeaderRefresh extends RefreshIndicator {
  HeaderRefresh() : super(height: 80.0, refreshStyle: RefreshStyle.Follow);

  @override
  State<StatefulWidget> createState() {
    return HeaderRefreshState();
  }
}

class HeaderRefreshState extends RefreshIndicatorState<HeaderRefresh> {
  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return Container(
      child: Center(
        child: Lottie.asset(
          AppPath.loading,
          width:60,
          height:60,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

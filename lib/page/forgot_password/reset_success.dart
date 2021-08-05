import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/global/app_color.dart';
import 'package:t4edu_source_source/global/app_navigation.dart';
import 'package:t4edu_source_source/global/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';

class ResetSuccessPage extends StatefulWidget {
  final username;
  ResetSuccessPage({Key key, this.username}) : super(key: key);
  @override
  _ResetSuccessState createState() => _ResetSuccessState();
}

class _ResetSuccessState extends State<ResetSuccessPage> {
  GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.priColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
          margin: EdgeInsets.only(top: size.height * 0.05),
          height: size.height,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
            child: _buildBody(),
          ),
        ));
  }

  Widget _buildBody(){
    return Form(
      key: _key,
      child: ListView(
        children: [
          SizedBox(height: 5),
          _screenName(),
          SizedBox(height: 3),
          _subTittle(),
          SizedBox(
            height: 365,
            child: _successIcon(),
          ),
          _button()
        ],
      ),
    );
  }

  Widget _screenName() {
    return Text(
      LocaleKeys.resetSuccessTitle.tr(),
      style: TextStyle(
          color: AppColors.secColor, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _subTittle() {
    return Text(
      LocaleKeys.resetSuccessSubtitle.tr(),
      style: TextStyle(color: AppColors.thiColor, fontSize: 14),
    );
  }

  Widget _successIcon(){
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Done !",
        style: TextStyle(
          color: AppColors.secColor,
          fontSize: 30
        ),
      ),
    );
  }

  Widget _button(){
    return Container(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () async {
          GetIt.I<Navigation>().pushNamed(AppRouter.login);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.secColor),
          height: 50,
          child: Center(
            child: Text(
              LocaleKeys.loginNow.tr(),
              style: TextStyle(
                  color: AppColors.white, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

}
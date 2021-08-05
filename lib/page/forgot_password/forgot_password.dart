import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/global/app_color.dart';
import 'package:t4edu_source_source/global/app_navigation.dart';
import 'package:t4edu_source_source/global/app_routes.dart';
import 'package:t4edu_source_source/page/forgot_password/forgot_password_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  TextEditingController _usernameController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  ForgotPasswordBloc _forgotPasswordBloc;

  @override
  void initState() {
    super.initState();
    _forgotPasswordBloc = ForgotPasswordBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _forgotPasswordBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.priColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                GetIt.I<Navigation>().pop();
              },
            ),
            elevation: 0.0,
          ),
          body: Container(
            margin: EdgeInsets.only(top: size.height * 0.05),
            height: size.height,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
              child: StreamBuilder<bool>(
                stream: _forgotPasswordBloc.progressIndicatorValueStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) return Container();
                  return snapshot.data
                      ? Center(child: CircularProgressIndicator())
                      : _buildBody();
                },
              ),
            ),
          )),
    );
  }

  Widget _buildBody() {
    return Form(
      key: _key,
      child: ListView(
        children: [
          SizedBox(height: 5),
          _screenName(),
          SizedBox(height: 3),
          _subTittle(),
          SizedBox(height: 90),
          _textFieldUsername(),
          SizedBox(height: 20),
          _buttonFind(),
        ],
      ),
    );
  }

  Widget _screenName() {
    return Text(
      LocaleKeys.forgotPasswordTitle.tr(),
      style: TextStyle(
          color: AppColors.secColor, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _subTittle() {
    return Text(
      LocaleKeys.forgotPasswordSubtitle.tr(),
      style: TextStyle(color: AppColors.thiColor, fontSize: 14),
    );
  }

  Widget _textFieldUsername() {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: AppColors.itemBackground,
            prefixIcon: Icon(
              Icons.account_box,
              size: 18,
            ),
            hintText: LocaleKeys.hintUsername.tr(),
            hintStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.all(15),
            counterText: ""),
        onChanged: (value) {
          _forgotPasswordBloc.usernameValueSink.add(value);
          _forgotPasswordBloc.updateStateButton();
        },
        validator: (_) {
          if (_usernameController.text.length == 0) {
            _forgotPasswordBloc.enableButtonFindSink.add(false);
            return LocaleKeys.canNotBeEmpty.tr();
          } else
            return null;
        },
        autovalidateMode: AutovalidateMode.always,
        maxLength: 255,
      ),
    );
  }

  Widget _buttonFind() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: StreamBuilder<bool>(
                stream: _forgotPasswordBloc.enableButtonFindStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container();
                  }
                  return snapshot.data
                      ? InkWell(
                          onTap: () async {
                            bool success = await _forgotPasswordBloc
                                .userForgotPassword();
                            if(success){
                              GetIt.I<Navigation>().pushNamed(AppRouter.confirmOTPForPass,
                              arguments: _usernameController.text);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.secColor),
                            height: 50,
                            width: 140,
                            child: Center(
                              child: Text(
                                LocaleKeys.search.tr(),
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.secColor),
                          height: 50,
                          width: 140,
                          child: Center(
                            child: Text(
                              LocaleKeys.search.tr(),
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 14),
                            ),
                          ),
                        );
                }),
          ),
        ),
        SizedBox(width: 30),
        Expanded(flex: 1, child: Container())
      ],
    );
  }
}

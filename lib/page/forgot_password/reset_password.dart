import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/global/app_color.dart';
import 'package:t4edu_source_source/global/app_navigation.dart';
import 'package:t4edu_source_source/global/app_routes.dart';
import 'package:t4edu_source_source/page/forgot_password/reset_password_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';

class ResetPasswordPage extends StatefulWidget {
  final token;
  ResetPasswordPage({Key key, @required this.token}) : super(key: key);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordPage> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  ResetPasswordBloc _resetPasswordBloc;

  ResetPasswordPage get widget => super.widget;

  @override
  void initState() {
    super.initState();
    _resetPasswordBloc = ResetPasswordBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _resetPasswordBloc.dispose();
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
                stream: _resetPasswordBloc.progressIndicatorValueStream,
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
          _subtitle(),
          SizedBox(height: 90),
          _textPassword(),
          _textFieldPassword(),
          SizedBox(height: 20),
          _textRepeatPassword(),
          _textFieldRepeatPassword(),
          SizedBox(height: 20),
          _buttonFind(),
        ],
      ),
    );
  }

  Widget _screenName() {
    return Text(
      LocaleKeys.changePassTitle.tr(),
      style: TextStyle(
          color: AppColors.secColor, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _subtitle() {
    return Text(
      LocaleKeys.changePassSubtitle.tr(),
      style: TextStyle(color: AppColors.thiColor, fontSize: 14),
    );
  }

  Widget _textPassword() {
    return Container(
        alignment: Alignment.topLeft,
        child: Text(
          LocaleKeys.changePassSubtitle.tr(),
          style: TextStyle(color: AppColors.secColor, fontSize: 12),
        ));
  }

  Widget _textFieldPassword() {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: StreamBuilder<bool>(
          stream: _resetPasswordBloc.obscureText1ValueStream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            }
            return snapshot.data
                ? TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: AppColors.itemBackground,
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          size: 18,
                        ),
                        hintText: LocaleKeys.hintPassword.tr(),
                        hintStyle: TextStyle(fontSize: 12),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            size: 18,
                          ),
                          onPressed: () {
                            _resetPasswordBloc.updateStatePassword(true);
                          },
                        ),
                        contentPadding: EdgeInsets.all(15),
                        counterText: ""),
                    obscureText: true,
                    onChanged: (value) {
                      _resetPasswordBloc.passwordValueSink.add(value);
                      _resetPasswordBloc.updateStateButton();
                    },
                    validator: (_) {
                      if (_passwordController.text.length == 0) {
                        return LocaleKeys.canNotBeEmpty.tr();
                      } else if (_passwordController.text.length < 5) {
                        return LocaleKeys.passwordAtLeast.tr();
                      } else
                        return null;
                    },
                    autovalidateMode: AutovalidateMode.always,
                    maxLength: 100,
                  )
                : TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: AppColors.itemBackground,
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          size: 18,
                        ),
                        hintText: LocaleKeys.hintPassword.tr(),
                        hintStyle: TextStyle(fontSize: 13),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            size: 18,
                          ),
                          onPressed: () {
                            _resetPasswordBloc.updateStatePassword(false);
                          },
                        ),
                        contentPadding: EdgeInsets.all(15),
                        counterText: ""),
                    obscureText: false,
                    onChanged: (value) {
                      _resetPasswordBloc.passwordValueSink.add(value);
                      _resetPasswordBloc.updateStateButton();
                    },
                    validator: (_) {
                      if (_passwordController.text.length == 0) {
                        return LocaleKeys.canNotBeEmpty.tr();
                      } else if (_passwordController.text.length < 5) {
                        return LocaleKeys.passwordAtLeast.tr();
                      } else
                        return null;
                    },
                    autovalidateMode: AutovalidateMode.always,
                    maxLength: 100,
                  );
          }),
    );
  }

  Widget _textRepeatPassword() {
    return Container(
        alignment: Alignment.topLeft,
        child: Text(
          LocaleKeys.repeatNewPassword.tr(),
          style: TextStyle(color: AppColors.secColor, fontSize: 12),
        ));
  }

  Widget _textFieldRepeatPassword() {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: StreamBuilder<bool>(
          stream: _resetPasswordBloc.obscureText2ValueStream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            }
            return snapshot.data
                ? TextFormField(
                    controller: _repeatPasswordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: AppColors.itemBackground,
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          size: 18,
                        ),
                        hintText: LocaleKeys.hintPassword.tr(),
                        hintStyle: TextStyle(fontSize: 12),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            size: 18,
                          ),
                          onPressed: () {
                            _resetPasswordBloc.updateStateRepeatPassword(true);
                          },
                        ),
                        contentPadding: EdgeInsets.all(15),
                        counterText: ""),
                    obscureText: true,
                    onChanged: (value) {
                      _resetPasswordBloc.repeatPasswordValueSink.add(value);
                      _resetPasswordBloc.updateStateButton();
                    },
                    validator: (_) {
                      if (_repeatPasswordController.text.length == 0) {
                        return LocaleKeys.canNotBeEmpty.tr();
                      } else if (_repeatPasswordController.text ==
                          _passwordController.text) {
                        return null;
                      } else
                        return LocaleKeys.passwordMismatched.tr();
                    },
                    autovalidateMode: AutovalidateMode.always,
                    maxLength: 100,
                  )
                : TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: AppColors.itemBackground,
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          size: 18,
                        ),
                        hintText: LocaleKeys.hintPassword.tr(),
                        hintStyle: TextStyle(fontSize: 13),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            size: 18,
                          ),
                          onPressed: () {
                            _resetPasswordBloc.updateStateRepeatPassword(false);
                          },
                        ),
                        contentPadding: EdgeInsets.all(15),
                        counterText: ""),
                    obscureText: false,
                    onChanged: (value) {
                      _resetPasswordBloc.repeatPasswordValueSink.add(value);
                      _resetPasswordBloc.updateStateButton();
                    },
                    validator: (_) {
                      if (_repeatPasswordController.text.length == 0) {
                        return LocaleKeys.canNotBeEmpty.tr();
                      } else if (_repeatPasswordController.text ==
                          _passwordController.text) {
                        return null;
                      } else
                        return LocaleKeys.passwordMismatched.tr();
                    },
                    autovalidateMode: AutovalidateMode.always,
                    maxLength: 100,
                  );
          }),
    );
  }

  Widget _buttonFind() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: StreamBuilder<bool>(
                stream: _resetPasswordBloc.enableButtonConfirmStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container();
                  }
                  return snapshot.data
                      ? InkWell(
                          onTap: () async {
                            bool success = await _resetPasswordBloc
                                .userResetPassword(widget.token.toString());
                            if (success) {
                              GetIt.I<Navigation>()
                                  .pushNamed(AppRouter.resetSuccess);
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
                                LocaleKeys.finish.tr(),
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
                              LocaleKeys.finish.tr(),
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 14),
                            ),
                          ),
                        );
                }),
          ),
        ),
        SizedBox(width: 20),
        Expanded(flex: 1, child: Container())
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/global/app_color.dart';
import 'package:t4edu_source_source/global/app_navigation.dart';
import 'package:t4edu_source_source/global/app_routes.dart';
import 'package:t4edu_source_source/page/login/login_bloc.dart';
import 'package:t4edu_source_source/page/register/register_page.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  LoginBloc _loginBloc;
  LoginCase loginCase;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
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
                /// Navigate to previous Screen
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
                stream: _loginBloc.progressIndicatorValueStream,
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
          _welcome(),
          SizedBox(height: 90),
          _textFieldUsername(),
          SizedBox(height: 20),
          _textFieldPassword(),
          SizedBox(height: 20),
          _forgotPassword(),
          SizedBox(height: 30),
          _logAndSign(),
          SizedBox(height: 45),
          _otherLoginMethods(),
          SizedBox(height: 24)
        ],
      ),
    );
  }

  Widget _screenName() {
    return Text(
      LocaleKeys.login.tr(),
      style: TextStyle(
          color: AppColors.secColor, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _welcome() {
    return Text(
      LocaleKeys.welcome.tr(),
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
          _loginBloc.usernameValueSink.add(value);
          _loginBloc.updateStateButton();
        },
        validator: (_) {
          if (_usernameController.text.length == 0) {
            return LocaleKeys.canNotBeEmpty.tr();
          } else
            return null;
        },
        autovalidateMode: AutovalidateMode.always,
        maxLength: 255,
      ),
    );
  }

  Widget _textFieldPassword() {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: StreamBuilder<bool>(
          stream: _loginBloc.obscureTextValueStream,
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
                            _loginBloc.updateStatePassword(true);
                          },
                        ),
                        contentPadding: EdgeInsets.all(15),
                        counterText: ""),
                    obscureText: true,
                    onChanged: (value) {
                      _loginBloc.passwordValueSink.add(value);
                      _loginBloc.updateStateButton();
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
                            _loginBloc.updateStatePassword(false);
                          },
                        ),
                        contentPadding: EdgeInsets.all(15),
                        counterText: ""),
                    obscureText: false,
                    onChanged: (value) {
                      _loginBloc.passwordValueSink.add(value);
                      _loginBloc.updateStateButton();
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

  Widget _forgotPassword() {
    return Container(
        alignment: Alignment.topLeft,
        child: InkWell(
          child: Text(
            LocaleKeys.forgotPassword.tr(),
            style: TextStyle(color: AppColors.secColor, fontSize: 12),
          ),
          onTap: () {
            /// Navigate to ForgotPasswordScreen
          },
        ));
  }

  Widget _logAndSign() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: StreamBuilder<bool>(
                stream: _loginBloc.enableButtonLoginStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container();
                  }
                  return snapshot.data
                      ? InkWell(
                          onTap: () async {
                            loginCase = await _loginBloc.userLogin();
                            if (loginCase != null) {
                              if (loginCase == LoginCase.HaveRole) {
                                ///Navigate to Home Screen
                              }
                              if (loginCase == LoginCase.HaveNoRole) {
                                return _messageBox(
                                    LocaleKeys.messBoxTitle1.tr(),
                                    LocaleKeys.messBoxContent1.tr(),
                                    LocaleKeys.messBoxTextButton1.tr(),
                                    AppRouter.login);

                                ///Navigate to Choose Role Screean
                              }
                              if (loginCase == LoginCase.Unverified) {
                                return _messageBox(
                                    LocaleKeys.messBoxTitle2.tr(),
                                    LocaleKeys.messBoxContent2.tr(),
                                    LocaleKeys.messBoxTextButton2.tr(),
                                    AppRouter.login);

                                ///Navigate to Verify Screen
                              }
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
                                LocaleKeys.login.tr(),
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
                              LocaleKeys.login.tr(),
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 14),
                            ),
                          ),
                        );
                }),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                child: Text(
                  LocaleKeys.signup.tr(),
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  /// Navigate to SignUpScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _otherLoginMethods() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              LocaleKeys.orLoginWith.tr(),
              style: TextStyle(color: AppColors.secColor, fontSize: 12),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.secColor),
                height: 50,
                width: 50,
                child: Center(
                  child: Text(
                    "F",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.orange),
                height: 50,
                width: 50,
                child: Center(
                  child: Text(
                    "G+",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _messageBox(
      String title, String message, String textButton, String routeName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(textButton),
              onPressed: () {
                GetIt.I<Navigation>().pushNamed(routeName);
              },
            ),
          ],
        );
      },
    );
  }
}

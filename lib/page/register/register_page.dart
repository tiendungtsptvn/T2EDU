import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t4edu_source_source/global/app_color.dart';
import 'package:t4edu_source_source/global/app_demension.dart';
import 'package:t4edu_source_source/page/otp%20register/otp_register_page.dart';
import 'package:t4edu_source_source/page/register/register_bloc.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _key = GlobalKey();
  RegisterBloc registerBloc = new RegisterBloc();
  TextEditingController emailOrPhoneNumberController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    registerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Navigator.of(context,rootNavigator: true).pop();
              registerBloc.dispose();
            },
          ),
          elevation: 0.0,
        ),
        body: Container(
          margin: EdgeInsets.only(top: getHeight(context) * 0.05),
          height: getHeight(context),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
            child: StreamBuilder<bool>(
              stream: registerBloc.isWaitingRegister,
              builder: (context, snapshot) {
                if (snapshot.data == null) return Container();
                return snapshot.data
                    ? Center(child: CircularProgressIndicator())
                    : _buildBody();
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return Form(
      key: _key,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            LocaleKeys.newRegister.tr(),
            style: TextStyle(
                color: AppColors.secColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 3),
          Text(
            LocaleKeys.welcome.tr(),
            style: TextStyle(color: AppColors.thiColor, fontSize: 14),
          ),
          SizedBox(height: 90),
          TextField(
            controller: emailOrPhoneNumberController,
            keyboardType: getTextInput(),
            decoration: buildInputDecoration(
                Icons.email, LocaleKeys.emailOrPhoneNumber.tr()),
            onChanged: (value) {
              registerBloc.emailOrPhoneValueSink.add(value);
              registerBloc.updateButtonState();
            },
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                  child: TextField(
                    keyboardType: getTextInput(),
                    decoration: buildInputDecoration(
                        Icons.person, LocaleKeys.firstName.tr()),
                    onChanged: (value) {
                      registerBloc.firstNameValueSink.add(value);
                      registerBloc.updateButtonState();
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: TextField(
                  keyboardType: getTextInput(),
                  decoration: buildInputDecoration(
                      Icons.person, LocaleKeys.lastName.tr()),
                  onChanged: (value) {
                    registerBloc.lastNameValueSink.add(value);
                    registerBloc.updateButtonState();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          StreamBuilder<bool>(
              stream: registerBloc.obscurePassStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                }
                return TextField(
                  keyboardType: getTextInput(),
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
                        registerBloc.updateObscureState(snapshot.data);
                      },
                    ),
                  ),
                  obscureText: snapshot.data,
                  onChanged: (value) {
                    registerBloc.registeredPassValueSink.add(value);
                    registerBloc.updateButtonState();
                  },
                );
              }),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<bool>(
              stream: registerBloc.obscurePassStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                }
                return TextField(
                  keyboardType: getTextInput(),
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
                    hintText: LocaleKeys.rePassword.tr(),
                    hintStyle: TextStyle(fontSize: 13),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        size: 18,
                      ),
                      onPressed: () {
                        registerBloc.updateObscureState(snapshot.data);
                      },
                    ),
                  ),
                  obscureText: snapshot.data,
                  onChanged: (value) {
                    registerBloc.rePassValueSink.add(value);
                    registerBloc.updateButtonState();
                  },
                );
              }),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              StreamBuilder<bool>(
                  stream: registerBloc.isCheckValueStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    } else {
                      return Checkbox(
                        value: snapshot.data,
                        shape: RoundedRectangleBorder(),
                        onChanged: (bool value) {
                          registerBloc.updateCheckBox(value);
                        },
                      );
                    }
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                child: Text(
                  'Tôi đồng ý với các điều khoản sử dụng',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<bool>(
              stream: registerBloc.enableRegisterButtonStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                }
                return ElevatedButton(
                  onPressed: snapshot.data
                      ? () async {
                          // String response =
                          //     await registerBloc.registerAccount();
                          // if (response != null) {
                          //   ///Navigte to OTP code confirm
                          //   Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => OTPRegisterPage(
                          //               emailOrPhoneNumber:
                          //                   emailOrPhoneNumberController.text
                          //                       .toString(),
                          //             )),
                          //   );
                          // }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OTPRegisterPage(
                                      emailOrPhoneNumber:
                                          emailOrPhoneNumberController.text
                                              .toString(),
                                    )),
                          );
                        }
                      : () {},
                  style: ElevatedButton.styleFrom(
                    primary: snapshot.data
                        ? AppColors.secColor
                        : AppColors.light_grey,
                  ),
                  child: Text(
                    LocaleKeys.register.tr(),
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                );
              }),
        ],
      ),
    );
  }

  getTextInput() {
    if (Platform.isIOS) {
      return TextInputType.name;
    } else if (Platform.isAndroid) {
      return TextInputType.name;
    }
  }

  buildInputDecoration(IconData icon, String hint) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: AppColors.itemBackground,
        prefixIcon: Icon(
          icon,
          size: 18,
        ),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 13));
  }
}

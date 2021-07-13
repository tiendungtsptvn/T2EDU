

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:t4edu_source_source/global/app_color.dart';
import 'package:t4edu_source_source/page/login/login_bloc.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login>{

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
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
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
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
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)
            )
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: _buildBody(),
          ),
        )
      ),
    );
  }
  Widget _buildBody() {
    return Form(
      key: _key,
      child: ListView(
        children: [
          SizedBox(height: 5),
          screenName(),
          SizedBox(height: 3),
          welcome(),
          SizedBox(height: 90),
          textFieldUsername(),
          SizedBox(height: 20),
          textFieldPassword(),
          SizedBox(height: 20),
          fogotPassword(),
          SizedBox(height: 30,),
          logAndSign(),
          SizedBox(height: 50,),
          otherLoginMethods()
        ],
      ),
    );
  }

  Widget screenName(){
    return Text(
      LocaleKeys.login.tr(),
      style: TextStyle(
        color: AppColors.secColor,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),

    );
  }

  Widget welcome(){
    return Text(
      LocaleKeys.welcome.tr(),
      style: TextStyle(
        color: AppColors.thiColor,
        fontSize: 14
      ),
    );
  }

  Widget textFieldUsername(){
    return Container(
      height: 48,
      child: TextField(
        keyboardType: _getTextInput(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none
          ),
          filled: true,
          fillColor: AppColors.itemBackground,
          prefixIcon: Icon(
            Icons.account_box,
            size: 18,
          ),
          hintText: LocaleKeys.hintUsername.tr(),
          hintStyle: TextStyle(
            fontSize: 13
          )
        ),
        onChanged: (value){
          _loginBloc.usernameValueSink.add(value);
          _loginBloc.updateStateButton();
        },
      ),
    );
  }

  _getTextInput() {
    if (Platform.isIOS) {
      return TextInputType.name;
    } else if (Platform.isAndroid) {
      return TextInputType.name;
    }
  }

  Widget textFieldPassword(){
    return Container(
      height: 48,
      child: StreamBuilder<bool>(
        stream: _loginBloc.obscureTextValueStream,
        builder: (context, snapshot){
          if(snapshot.data == null){
            return Container();
          }
          return snapshot.data
            ? TextField(
              keyboardType: _getTextInput(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: AppColors.itemBackground,
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  size: 18,
                ),
                hintText: LocaleKeys.hintPassword.tr(),
                hintStyle: TextStyle(
                    fontSize: 13
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    size: 18,
                  ),
                  onPressed: (){
                    _loginBloc.updateStatePassword(true);
                  },
                ),
              ),
              obscureText: true,
              onChanged: (value){
                _loginBloc.passwordValueSink.add(value);
                _loginBloc.updateStateButton();
              },
            )
            : TextField(
              keyboardType: _getTextInput(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: AppColors.itemBackground,
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  size: 18,
                ),
                hintText: LocaleKeys.hintPassword.tr(),
                hintStyle: TextStyle(
                    fontSize: 13
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    size: 18,
                  ),
                  onPressed: (){
                    _loginBloc.updateStatePassword(false);
                  },
                )
              ),
              obscureText: false,
              onChanged: (value){
                _loginBloc.passwordValueSink.add(value);
                _loginBloc.updateStateButton();
              },
            );
        }
      ),
    );
  }

  Widget fogotPassword(){
    return Container(
      alignment: Alignment.topLeft,
      child: InkWell(
        child: Text(
          LocaleKeys.forgotPassword.tr(),
          style: TextStyle(
              color: AppColors.secColor,
              fontSize: 12
          ),
        ),
        onTap: (){

        },
      )
    );
  }

  Widget logAndSign(){
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: StreamBuilder<bool>(
              stream: _loginBloc.enableButtonLoginStream,
              builder: (context, snapshot) {
                if(snapshot.data == null){
                  return Container();
                }
                return snapshot.data
                ? InkWell(
                    onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.secColor
                      ),
                      height: 50,
                      width: 140,
                      child: Center(
                        child: Text(
                          LocaleKeys.login.tr(),
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14
                          ),
                        ),
                      ),
                    ),
                )
                : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.lightGrey
                  ),
                  height: 50,
                  width: 140,
                  child: Center(
                    child: Text(
                      LocaleKeys.login.tr(),
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14
                      ),
                    ),
                  ),
                );
              }
            ),
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
                      decoration: TextDecoration.underline
                  ),

                ),
                onPressed: (){

                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget otherLoginMethods(){
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              LocaleKeys.orLoginWith.tr(),
              style: TextStyle(
                color: AppColors.secColor,
                fontSize: 12
              ),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.secColor
                ),
                height: 50,
                width: 50,
                child: Center(
                  child: Text(
                    "F",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.orange
                ),
                height: 50,
                width: 50,
                child: Center(
                  child: Text(
                    "G+",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}
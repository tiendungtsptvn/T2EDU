import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:t4edu_source_source/global/app_color.dart';
import 'package:t4edu_source_source/global/app_demension.dart';
import 'package:t4edu_source_source/page/otp%20register/otp_register_bloc.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class OTPRegisterPage extends StatefulWidget {
  final String emailOrPhoneNumber;

  const OTPRegisterPage({Key key, this.emailOrPhoneNumber}) : super(key: key);

  @override
  _OTPRegisterPageState createState() => _OTPRegisterPageState();
}

class _OTPRegisterPageState extends State<OTPRegisterPage> {
  OTPRegisterBloc otpRegisterBloc = new OTPRegisterBloc();
  GlobalKey _key = new GlobalKey();
  TextEditingController codeController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    otpRegisterBloc.dispose();
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
              otpRegisterBloc.dispose();
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          elevation: 0.0,
        ),
        body: Container(
            margin: EdgeInsets.only(top: getHeight(context) * 0.05),
            height: getHeight(context),
            width: getWidth(context),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
              child: _buildBody(),
            )),
      ),
    );
  }

  Widget _buildBody() {
    return Form(
      key: _key,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            LocaleKeys.otpConfirm.tr(),
            style: TextStyle(
                color: AppColors.secColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 3),
          Text(
            LocaleKeys.otpSubtitleHeader.tr(),
            style: TextStyle(color: AppColors.thiColor, fontSize: 14),
          ),
          SizedBox(height: 90),
          TextFormField(
            controller: codeController,
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: 140,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.secColor,
                elevation: 5,
              ),
              onPressed: () async {
                bool isSuccess = await otpRegisterBloc
                    .registerConfirm(widget.emailOrPhoneNumber,codeController.text.toString());
                print(isSuccess.toString());
                if (isSuccess == true) {
                  ///Navigate to choose role
                }
              },
              child: Text(
                LocaleKeys.confirm.tr(),
                style: TextStyle(color: AppColors.white, fontSize: 14),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(LocaleKeys.haveNotReceiveCodeYet.tr(),
                  style: TextStyle(
                    color: AppColors.priColor,
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: StreamBuilder(
                    stream: otpRegisterBloc.isCountingTtoResendStream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                      } else {
                        return snapshot.data
                            ? new TweenAnimationBuilder<Duration>(
                                duration: Duration(seconds: 10),
                                tween: Tween(
                                    begin: Duration(seconds: 10),
                                    end: Duration.zero),
                                onEnd: () {
                                  otpRegisterBloc.isCountingToResendSink
                                      .add(false);
                                },
                                builder: (BuildContext context, Duration value,
                                    Widget child) {
                                  final seconds = value.inSeconds % 60;
                                  return Text(
                                      LocaleKeys.resend.tr() +
                                          '(' +
                                          '$seconds' +
                                          's)',
                                      style: TextStyle(
                                        color: AppColors.priColor,
                                      ));
                                })
                            : GestureDetector(
                                onTap: () async {
                                  otpRegisterBloc.isCountingToResendSink
                                      .add(true);
                                  bool isSuccess = await otpRegisterBloc
                                      .resendOTP(widget.emailOrPhoneNumber);
                                  print(
                                      'result resend: ' + isSuccess.toString());
                                },
                                child: Text(LocaleKeys.resend.tr(),
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColors.priColor,
                                    )));
                      }
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

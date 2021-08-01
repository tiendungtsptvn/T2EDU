import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/global/app_color.dart';
import 'package:t4edu_source_source/global/app_navigation.dart';
import 'package:t4edu_source_source/page/forgot_password/confirm_otp_bloc.dart';

class ConfirmOTPPage extends StatefulWidget {
  @override
  _ConfirmOTPState createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends State<ConfirmOTPPage> {
  GlobalKey<FormState> _key = GlobalKey();
  ConfirmOTPBloc _confirmOTPBloc;
  FocusNode pinFocusNode,
      pin2FocusNode,
      pin3FocusNode,
      pin4FocusNode,
      pin5FocusNode,
      pin6FocusNode;
  TextEditingController pinController = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
  TextEditingController pin3Controller = TextEditingController();
  TextEditingController pin4Controller = TextEditingController();
  TextEditingController pin5Controller = TextEditingController();
  TextEditingController pin6Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _confirmOTPBloc = ConfirmOTPBloc();
    pinFocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pinFocusNode?.dispose();
    pin2FocusNode?.dispose();
    pin3FocusNode?.dispose();
    pin4FocusNode?.dispose();
    pin5FocusNode?.dispose();
    pin6FocusNode?.dispose();
    _confirmOTPBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
            child: _buildBody(),
          ),
        ));
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
          _otpForm(),
          _validatorOTP(),
          SizedBox(height: 10),
          _confirm(),
          SizedBox(height: 20),
          _resendOTP(),
        ],
      ),
    );
  }

  Widget _screenName() {
    return Text(
      "Xác thực OTP",
      style: TextStyle(
          color: AppColors.secColor, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _welcome() {
    return Text(
      "Hệ thống đã gửi cho bạn mã OTP!",
      style: TextStyle(color: AppColors.thiColor, fontSize: 14),
    );
  }

  Widget _otpForm() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 45,
            height: 45,
            child: TextFormField(
              controller: pinController,
              autofocus: true,
              style: TextStyle(fontSize: 18),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.priColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.priColor),
                ),
                counterText: "",
              ),
              onChanged: (value) {
                _confirmOTPBloc.pinValueSink.add(value.toString());
                _confirmOTPBloc.updateStateValidate();
                checkPin();
                nextField(value, pin2FocusNode);
              },
              maxLength: 1,
            ),
          ),
          SizedBox(
            width: 45,
            height: 45,
            child: TextFormField(
              controller: pin2Controller,
              focusNode: pin2FocusNode,
              style: TextStyle(fontSize: 18),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.priColor),
                ),
                counterText: "",
              ),
              onChanged: (value) {
                _confirmOTPBloc.pin2ValueSink.add(value);
                _confirmOTPBloc.updateStateValidate();
                checkPin();
                nextField(value, pin3FocusNode);
              },
              maxLength: 1,
            ),
          ),
          SizedBox(
            width: 45,
            height: 45,
            child: TextFormField(
              controller: pin3Controller,
              focusNode: pin3FocusNode,
              style: TextStyle(fontSize: 18),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.priColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.priColor),
                ),
                counterText: "",
              ),
              onChanged: (value) {
                _confirmOTPBloc.pin3ValueSink.add(value);
                _confirmOTPBloc.updateStateValidate();
                checkPin();
                nextField(value, pin4FocusNode);
              },
              maxLength: 1,
            ),
          ),
          SizedBox(
            width: 45,
            height: 45,
            child: TextFormField(
              controller: pin4Controller,
              focusNode: pin4FocusNode,
              style: TextStyle(fontSize: 18),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.priColor),
                ),
                counterText: "",
              ),
              onChanged: (value) {
                _confirmOTPBloc.pin4ValueSink.add(value);
                _confirmOTPBloc.updateStateValidate();
                checkPin();
                nextField(value, pin5FocusNode);
              },
              maxLength: 1,
            ),
          ),
          SizedBox(
            width: 45,
            height: 45,
            child: TextFormField(
              controller: pin5Controller,
              focusNode: pin5FocusNode,
              style: TextStyle(fontSize: 18),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.priColor),
                ),
                counterText: "",
              ),
              onChanged: (value) {
                _confirmOTPBloc.pin5ValueSink.add(value);
                _confirmOTPBloc.updateStateValidate();
                checkPin();
                nextField(value, pin6FocusNode);
              },
              maxLength: 1,
            ),
          ),
          SizedBox(
            width: 45,
            height: 45,
            child: TextFormField(
              controller: pin6Controller,
              focusNode: pin6FocusNode,
              style: TextStyle(fontSize: 18),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.priColor),
                ),
                counterText: "",
              ),
              onChanged: (value) {

                  _confirmOTPBloc.pin6ValueSink.add(value);
                  _confirmOTPBloc.updateStateValidate();
                  checkPin();
                  pin6FocusNode.unfocus();
              },
              maxLength: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _validatorOTP(){
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: StreamBuilder<OTPValidator>(
        stream: _confirmOTPBloc.otpValidateValueStream,
        builder: (context, snapshot){
          if(snapshot.data == null){
            return Container();
          }
          else if(snapshot.data == OTPValidator.Empty){
            return SizedBox(
              height: 20,
              child: Text(
                "Không được bỏ trống",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.red
                ),
              ),
            );
          }
          else if(snapshot.data == OTPValidator.Unvalidated){
            return SizedBox(
              height: 20,
              child: Text(
                "Không hợp lệ",
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.red
                ),
              ),
            );
          }
          else{
            return SizedBox(height: 20);
          }
        },
      ),
    );
  }

  Widget _confirm() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: StreamBuilder<bool>(
                  stream: _confirmOTPBloc.enableButtonConfirmStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    }
                    return snapshot.data
                        ? InkWell(
                      onTap: () async {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.secColor),
                        height: 50,
                        width: 140,
                        child: Center(
                          child: Text(
                            "Xác nhận",
                            style:
                            TextStyle(color: AppColors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.grey),
                      height: 50,
                      width: 140,
                      child: Center(
                        child: Text(
                          "Xác nhận",
                          style: TextStyle(color: AppColors.white, fontSize: 14),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: Container(),
          )
        ],
      ),
    );
  }

  Widget _resendOTP(){
    return Container(
      child: Row(
        children: [
          Text(
            "Chưa nhận được mã xác thực?",
            style: TextStyle(color: AppColors.secColor, fontSize: 12),
          ),
          SizedBox(width: 20),
          TextButton(
            child: Text(
              "Gửi Lại",
              style: TextStyle(
                  color: AppColors.priColor,
                  fontSize: 14,
                  decoration: TextDecoration.underline),
            ),
            onPressed: () {
              /// resend otp
            },
          ),
        ],
      ),
    );
  }

  void checkPin(){
    if(pinController.text != "" && pin2Controller.text != "" &&
        pin3Controller.text != "" && pin4Controller.text != "" &&
        pin5Controller.text != "" && pin6Controller.text != "" ) {
      _confirmOTPBloc.otpValidateValueSink.add(OTPValidator.Validated);
      _confirmOTPBloc.enableButtonConfirmSink.add(true);
    }
    else if(pinController.text == "" && pin2Controller.text == "" &&
        pin3Controller.text == "" && pin4Controller.text == "" &&
        pin5Controller.text == "" && pin6Controller.text == ""){
      _confirmOTPBloc.otpValidateValueSink.add(OTPValidator.Empty);
      _confirmOTPBloc.enableButtonConfirmSink.add(false);
    }
    else{
      _confirmOTPBloc.otpValidateValueSink.add(OTPValidator.Unvalidated);
      _confirmOTPBloc.enableButtonConfirmSink.add(false);
    }
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }


}

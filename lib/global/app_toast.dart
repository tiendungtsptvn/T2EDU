import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_color.dart';

class AppToast{
  static void showError(String message){
    String mms = message != null ? message.trim() : "";

    if(mms.isEmpty || mms == "ERR01"){
      return;
    }

    Fluttertoast.showToast(
        msg: mms,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.pink,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showWarning(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.yellow,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showSuccess(String message, [int duration = 2]) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: duration,
        backgroundColor: AppColors.light_green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
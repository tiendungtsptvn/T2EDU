import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTextStyles {
  static TextStyle normal({Color color = AppColors.black, double fontSize, fontFamily: "Custom font", FontWeight fontWeight}) {
    return TextStyle(color: color, fontSize: fontSize ?? 14, fontFamily: "Custom font", fontWeight: fontWeight);
  }

  static TextStyle italic({Color color = AppColors.black, double fontSize, fontFamily: "Custom font", FontWeight fontWeight}) {
    return TextStyle(color: color, fontSize: fontSize ?? 14, fontFamily: "Custom font", fontWeight: fontWeight,fontStyle: FontStyle.italic);
  }
}

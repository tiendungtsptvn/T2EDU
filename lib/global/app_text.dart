import 'package:flutter/material.dart';
import 'package:t4edu_source_source/global/app_textStyle.dart';

class AppTexts{
  static Text normal(String text,
      {Color color, FontWeight fontWeight = FontWeight.normal,double fontSize, TextOverflow textOverflow, int maxLines, TextAlign textAlign}) {
    TextStyle style = AppTextStyles.normal();
    if (color != null) {
      style = style.copyWith(color: color);
    }
    return Text(text, overflow:textOverflow??TextOverflow.ellipsis,
        style: style.copyWith(fontWeight: fontWeight,fontSize: fontSize, ),
      maxLines: maxLines??1,
      textAlign: textAlign??TextAlign.left,
    );
  }

  static Text italic(String text,
      {Color color, FontWeight fontWeight = FontWeight.normal,double fontSize, TextOverflow textOverflow, int maxLines}) {
    TextStyle style = AppTextStyles.italic();
    if (color != null) {
      style = style.copyWith(color: color);
    }
    return Text(text, overflow:textOverflow??TextOverflow.ellipsis,style: style.copyWith(fontWeight: fontWeight,fontSize: fontSize,),
      maxLines: maxLines,
    );
  }
}
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:t4edu_source_source/global/app_const.dart';
import 'package:t4edu_source_source/global/app_path.dart';
import 'package:t4edu_source_source/instance/global_data.dart';
import 'package:t4edu_source_source/source/local/pref.dart';

class Language {
  static const VN = Language._('VIE', AppPath.viFlag, "vi", "");
  static const ENG = Language._('ENG', AppPath.usFlag, "en", "");

  static const values = [VN, ENG];

  static const supportedLocales = [
    Locale('vi', ''),
    Locale('en', ''),
  ];

  final String text;
  final String image;
  final String languageCode;
  final String countryCode;

  const Language._(this.text, this.image, this.languageCode, this.countryCode);

  Language(this.text, this.image, this.languageCode, this.countryCode);

  static Language fromJson(Map<String, dynamic> json) {
    return Language(
      json['text'],
      json['image'],
      json['languageCode'],
      json['countryCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['image'] = this.image;
    data['languageCode'] = this.languageCode;
    data['countryCode'] = this.countryCode;
    return data;
  }

  static Future<Language> getLanguage() async {
    try {
      String language =
      await Pref().getString(AppConst.languageDefault, defaultValue: "");

      Language lang = values[0];

      if (language.isNotEmpty) {
        lang = fromJson(json.decode(language));
      }

      return lang;
    } catch (error) {
      throw error;
    }
  }

  static initLanguage(context) async {
    Language lang = await getLanguage();
    EasyLocalization.of(context).setLocale(Locale(lang.languageCode, ''));
    GlobalData.instance().setCurrentLanguage(lang);
  }

  static Future saveLang(Language lang) async {
    try {
      await Pref().putString(AppConst.languageDefault, json.encode(lang));
      GlobalData.instance().setCurrentLanguage(lang);
    } catch (error) {

    }
  }
}

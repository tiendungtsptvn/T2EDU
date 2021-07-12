
import 'package:t4edu_source_source/global/app_local.dart';

class GlobalData {
  GlobalData._internal();

  factory GlobalData.instance() {
    _instance ??= GlobalData._internal();
    return _instance;
  }
  static GlobalData _instance;

  Language _currentLanguage;

  Language get currentLanguage => _currentLanguage;

  void setCurrentLanguage(Language lang) {
    _currentLanguage = lang;
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:t4edu_source_source/source/api/api_error.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';

class Utils {
  static String getMessageError(dynamic error, {String mms = ""}) {
    //errorCode ERR003, message = 'tai khoan sai'
    if (error is String) {
      return error + ' ' + mms;
    }

    if (error is ApiError || error is Exception) {
      if (error.message == null || error.message.isEmpty) {
        return LocaleKeys.an_error_occurred.tr() + mms;
      }
      return (error.message ?? '') + ' ' + (mms ?? '');
    }

    return LocaleKeys.an_error_occurred.tr() + mms;
  }
}

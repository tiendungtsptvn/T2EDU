// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "error_message_default": "Có lỗi kết nối đến máy chủ. Quý khách vui lòng thử lại",
  "something_error": "Đã có lỗi xảy ra. Vui lòng thử lại",
  "an_error_occurred": "Đã có lỗi xảy ra",
  "login": "Login",
  "comment1": "LoginScreen-->",
  "welcome": "Welcome to T4Edu!",
  "hintUsername": "Email or phone-number",
  "hintPassword": "Password",
  "forgotPassword": "Forgot your password?",
  "signup": "Sign up",
  "orLoginWith": "Or login with",
  "canNotBeEmpty": "This field can't be empty",
  "passwordAtLeast": "Password contains at least 5 characters",
  "messBoxTitle1": "Choose your role !",
  "messBoxContent1": "Please choose your role to continue.",
  "messBoxTextButton1": "Choose now",
  "messBoxTitle2": "Unverified !",
  "messBoxContent2": "Your account unverified. Please verify your account to continue.",
  "messBoxTextButton2": "Verify now"
};
static const Map<String,dynamic> vi = {
  "error_message_default": "Có lỗi kết nối đến máy chủ. Quý khách vui lòng thử lại",
  "something_error": "Đã có lỗi xảy ra. Vui lòng thử lại",
  "an_error_occurred": "Đã có lỗi xảy ra",
  "login": "Đăng Nhập",
  "comment1": "LoginScreen-->",
  "welcome": "Chào mừng bạn đến với T4Edu!",
  "hintUsername": "Địa chỉ email hoặc số điện thoại",
  "hintPassword": "Mật khẩu",
  "forgotPassword": "Quên mật khẩu?",
  "signup": "Đăng ký mới",
  "orLoginWith": "Hoặc đăng nhập với",
  "canNotBeEmpty": "Không được bỏ trống",
  "passwordAtLeast": "Mật khẩu chứa ít nhất 5 ký tự",
  "messBoxTitle1": "Chọn chức danh !",
  "messBoxContent1": "Vui Lòng chọn chức danh để tiếp tục trải nghiệm bạn nhé.",
  "messBoxTextButton1": "Chọn ngay",
  "messBoxTitle2": "Chưa xác thực !",
  "messBoxContent2": "Tài khoản của bạn chưa được xác thực, vui lòng xác thực để sử dụng dịch vụ.",
  "messBoxTextButton2": "Xác thực ngay"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "vi": vi};
}

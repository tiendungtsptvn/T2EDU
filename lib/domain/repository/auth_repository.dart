
abstract class AuthRepository {
  Future<Map> userLogin(String username, String password);
  Future<Map> registerAccount(String emailOrPhone, String firstName, String lastName,String pass);

  //OTP register from branch 31/07/2021
  Future<void> resendOTP(String emailOrPhone);
  Future<void> otpRegisterConfirm(String emailOrPhone,String code);

  Future<void> userForgotPassword(String username);
  Future<String> userConfirmCodeForPass(String code, String username);
  Future<void> userResetPassword(String password, String token);
}

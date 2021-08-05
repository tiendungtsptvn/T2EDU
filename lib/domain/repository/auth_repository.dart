
abstract class AuthRepository {
  Future<Map> userLogin(String username, String password);
  Future<void> userForgotPassword(String username);
  Future<String> userConfirmCodeForPass(String code, String username);
  Future<void> userResetPassword(String password, String token);
  Future<void> resendOTP (String emailOrPhone);
}

abstract class AuthRepository {
  Future<Map> userLogin(String username, String password);
  Future<Map> registerAccount(String emailOrPhone, String firstName, String lastName,String pass);

  //OTP register from branch 31/07/2021
  Future<Map> resendOTP(String emailOrPhone);
  Future<Map> otpRegisterConfirm(String emailOrPhone,String code);
}

abstract class AuthRepository {
  Future<Map> userLogin(String username, String password);
  Future<void> userForgotPassword(String username);
  Future<Map> userConfirmCodeForPass(String code, String username);
}
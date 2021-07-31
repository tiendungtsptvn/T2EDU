
abstract class AuthRepository {
  Future<Map> userLogin(String username, String password);
  Future<Map> registerAccount(String emailOrPhone, String firstName, String lastName,String pass);
}
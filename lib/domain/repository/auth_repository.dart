
abstract class AuthRepository {
  Future<Map> userLogin(String username, String password);
}
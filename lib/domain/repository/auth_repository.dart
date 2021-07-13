

abstract class AuthRepository {
  Future<void> login(String userName, String passWord);
  Future<void> signUp(String userName, String passWord);
}
import 'package:t4edu_source_source/domain/models/access_token.dart';

abstract class AccountRepository {
  Future<Token> userLogin(String username, String password);
}
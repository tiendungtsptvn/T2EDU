
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/domain/models/access_token.dart';
import 'package:t4edu_source_source/domain/repository/auth_repository.dart';
import 'package:t4edu_source_source/instance/Session.dart';
import 'package:t4edu_source_source/source/api/api_error.dart';
import 'package:t4edu_source_source/source/api/client/rest/auth_client.dart';

class AuthRepositoryIml extends AuthRepository {
  ClientAuth _clientAuth = GetIt.I<ClientAuth>();
  AuthRepositoryIml(this._clientAuth);

  @override
  Future<Token> userLogin(String username, String password) async{
    try{
      String path = "/auth/login";

      final dynamic response = await _clientAuth.post(path,data: <String, dynamic>{
        'emailOrPhone':username,
        'password':password
      });

      if (response is Map) {
        Token token =  Token.fromJson(response as Map<String, dynamic>);

        if (token != null) {
          Session.instance()
            ..setAccessToken(token.accessToken)
            ..setRefreshToken(token.refreshToken);
        }
        return token;
      }
      throw ApiError.fromResponse(response);
    }catch(error){
      throw error;
    }
  }
}
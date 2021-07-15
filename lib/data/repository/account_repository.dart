
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/domain/models/access_token.dart';
import 'package:t4edu_source_source/domain/repository/account_repository.dart';
import 'package:t4edu_source_source/instance/Session.dart';
import 'package:t4edu_source_source/source/api/client/rest/task_client.dart';

class AccountRepositoryIml extends AccountRepository {
  RestClient _clientAccount = GetIt.I<RestClient>();
  AccountRepositoryIml(this._clientAccount);

  @override
  Future<void> userLogin(String username, String password) async{
    try{
      String path = "/auth/login";

      final dynamic response = await _clientAccount.post(path,data: <String, dynamic>{
        'username':username,
        'password':password
      });

      if (response is Map) {
        Token token =  Token.fromJson(response as Map<String, dynamic>);

        if (token != null) {
          Session.instance()
            ..setAccessToken(token.accessToken)
            ..setRefreshToken(token.refreshToken);
        }
      }
    }catch(error){
      throw error;
    }
  }

}

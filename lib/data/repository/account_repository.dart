
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/domain/repository/account_repository.dart';
import 'package:t4edu_source_source/source/api/client/rest/auth_client.dart';
import 'package:t4edu_source_source/source/api/client/rest/rest_client.dart';

class AuthRepositoryIml extends AuthRepository {
  ClientAuth _clientAuth = GetIt.I<ClientAuth>();
  AuthRepositoryIml(this._clientAuth);

  @override
  Future<void> login(String userName, String passWord) {
    try{
      ///TODO
    }catch(e){
      ///TODO
    }
  }

  @override
  Future<void> signUp(String userName, String passWord) {
    try{
      ///TODO
    }catch(e){
      ///TODO
    }
  }

}

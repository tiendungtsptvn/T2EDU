
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/domain/repository/account_repository.dart';
import 'package:t4edu_source_source/source/api/client/rest/task_client.dart';

class AccountRepositoryIml extends AccountRepository {
  RestClient _clientAccount = GetIt.I<RestClient>();
  AccountRepositoryIml(this._clientAccount);

}

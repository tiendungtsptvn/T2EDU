import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:t4edu_source_source/base/bloc_base.dart';
import 'package:t4edu_source_source/data/repository/account_repository.dart';

class LoginBloc extends BlocBase{
  final AccountRepositoryIml _apiAccount = GetIt.I<AccountRepositoryIml>();
  LoginBloc() {
    _bind();
  }

  @override
  void init() async {
    super.init();
    _enableButtonLogin.add(false);
  }

  void _bind() {}

  final BehaviorSubject<bool> _enableButtonLogin =
  BehaviorSubject.seeded(false);
  // this constructor takes 1 argument which like a initial value
  Sink<bool> get enableButtonLoginSink => _enableButtonLogin.sink;
  Stream<bool> get enableButtonLoginStream => _enableButtonLogin.stream;

  final BehaviorSubject<String> _usernameValue = BehaviorSubject();
  Sink<String> get usernameValueSink => _usernameValue.sink;
  Stream<String> get usernameValueStream => _usernameValue.stream;

  final BehaviorSubject<String> _passwordValue = BehaviorSubject();
  Sink<String> get passwordValueSink => _passwordValue.sink;
  Stream<String> get passwordValueStream => _passwordValue.stream;

  final BehaviorSubject<bool> _obscureTextValue = BehaviorSubject.seeded(true);
  Sink<bool> get obscureTextValueSink => _obscureTextValue.sink;
  Stream<bool> get obscureTextValueStream => _obscureTextValue.stream;

  void updateStateButton() {
    if (_usernameValue.valueWrapper.value != "" &&
        _passwordValue.valueWrapper.value != "") {
      enableButtonLoginSink.add(true);
    } else
      enableButtonLoginSink.add(false);
  }

  void updateStatePassword(bool current){
    obscureTextValueSink.add(!current);
  }

  @override
  void dispose() {
    _enableButtonLogin.close();
    _usernameValue.close();
    _passwordValue.close();
    _obscureTextValue.close();
  }
}
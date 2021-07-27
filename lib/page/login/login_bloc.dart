import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:t4edu_source_source/base/bloc_base.dart';
import 'package:t4edu_source_source/data/repository/auth_repository.dart';
import 'package:t4edu_source_source/domain/models/access_token.dart';
import 'package:t4edu_source_source/global/app_toast.dart';
import 'package:t4edu_source_source/helpers/Utils.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginBloc extends BlocBase {
  final AuthRepositoryIml _apiAuth = GetIt.I<AuthRepositoryIml>();
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

  final BehaviorSubject<bool> _progressIndicatorValue
    = BehaviorSubject.seeded(false);
  Sink<bool> get progressIndicatorValueSink => _progressIndicatorValue.sink;
  Stream<bool> get progressIndicatorValueStream => _progressIndicatorValue.stream;

  void updateStateButton() {
    if (_usernameValue.valueWrapper.toString() != "" &&
        _passwordValue.valueWrapper.toString() != "" &&
        _passwordValue.valueWrapper.toString().length > 4) {
      if (!_enableButtonLogin.isClosed) _enableButtonLogin.add(true);
    } else if (!_enableButtonLogin.isClosed) _enableButtonLogin.add(false);
  }

  void updateStatePassword(bool current) {
    if(!_obscureTextValue.isClosed) _obscureTextValue.add(!current);
  }

  Future<void> userLogin() async {
    if(!_progressIndicatorValue.isClosed) _progressIndicatorValue.add(true);
    try {
      Token token = await _apiAuth.userLogin(
          _usernameValue.valueWrapper.value, _passwordValue.valueWrapper.value);

      if (token != null) {
        if(!_progressIndicatorValue.isClosed) _progressIndicatorValue.add(false);
        AppToast.showSuccess(LocaleKeys.welcome.tr());
      }
    } catch (e) {
      if(!_progressIndicatorValue.isClosed) _progressIndicatorValue.add(false);
      AppToast.showError(Utils.getMessageError(e));
    }
  }

  @override
  void dispose() {
    _enableButtonLogin?.close();
    _usernameValue?.close();
    _passwordValue?.close();
    _obscureTextValue?.close();
    _progressIndicatorValue?.close();
  }
}

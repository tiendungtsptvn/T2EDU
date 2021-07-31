import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:t4edu_source_source/base/bloc_base.dart';
import 'package:t4edu_source_source/data/repository/auth_repository.dart';
import 'package:t4edu_source_source/global/app_toast.dart';
import 'package:t4edu_source_source/helpers/Utils.dart';
import 'package:t4edu_source_source/source/api/api_error.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordBloc extends BlocBase {
  final AuthRepositoryIml _apiAuth = GetIt.I<AuthRepositoryIml>();

  ForgotPasswordBloc() {
    _bind();
  }

  @override
  void init() async {
    super.init();
  }

  void _bind() {}

  final BehaviorSubject<bool> _progressIndicatorValue =
  BehaviorSubject.seeded(false);
  Sink<bool> get progressIndicatorValueSink => _progressIndicatorValue.sink;
  Stream<bool> get progressIndicatorValueStream =>
      _progressIndicatorValue.stream;

  final BehaviorSubject<String> _usernameValue = BehaviorSubject();
  Sink<String> get usernameValueSink => _usernameValue.sink;
  Stream<String> get usernameValueStream => _usernameValue.stream;

  final BehaviorSubject<bool> _enableButtonLogin =
  BehaviorSubject.seeded(false);
  Stream<bool> get enableButtonLoginStream => _enableButtonLogin.stream;

  void updateStateButton() {
    if (_usernameValue.valueWrapper.toString() != "") {
      if (!_enableButtonLogin.isClosed) _enableButtonLogin.add(true);
    } else if (!_enableButtonLogin.isClosed) _enableButtonLogin.add(false);
  }

  @override
  void dispose() {
    _progressIndicatorValue?.close();
    _enableButtonLogin?.close();
    _usernameValue?.close();
  }
}
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:t4edu_source_source/base/bloc_base.dart';
import 'package:t4edu_source_source/data/repository/auth_repository.dart';
import 'package:t4edu_source_source/global/app_toast.dart';
import 'package:t4edu_source_source/helpers/Utils.dart';

class ResetPasswordBloc extends BlocBase {
  final AuthRepositoryIml _apiAuth = GetIt.I<AuthRepositoryIml>();

  ResetPasswordBloc() {
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

  final BehaviorSubject<bool> _obscureText1Value = BehaviorSubject.seeded(true);
  Sink<bool> get obscureText1ValueSink => _obscureText1Value.sink;
  Stream<bool> get obscureText1ValueStream => _obscureText1Value.stream;

  final BehaviorSubject<bool> _obscureText2Value = BehaviorSubject.seeded(true);
  Sink<bool> get obscureText2ValueSink => _obscureText2Value.sink;
  Stream<bool> get obscureText2ValueStream => _obscureText2Value.stream;

  final BehaviorSubject<String> _passwordValue = BehaviorSubject();
  Sink<String> get passwordValueSink => _passwordValue.sink;
  Stream<String> get passwordValueStream => _passwordValue.stream;

  final BehaviorSubject<String> _repeatPasswordValue = BehaviorSubject();
  Sink<String> get repeatPasswordValueSink => _repeatPasswordValue.sink;
  Stream<String> get repeatPasswordValueStream => _repeatPasswordValue.stream;

  final BehaviorSubject<bool> _enableButtonConfirm =
  BehaviorSubject.seeded(false);
  Stream<bool> get enableButtonConfirmStream => _enableButtonConfirm.stream;
  Sink<bool> get enableButtonConfirmSink => _enableButtonConfirm.sink;



  void updateStateButton() {
    if (_passwordValue.valueWrapper.toString() != "" &&
    _passwordValue.valueWrapper == _repeatPasswordValue.valueWrapper) {
      if (!_enableButtonConfirm.isClosed) _enableButtonConfirm.add(true);
    } else {
      if (!_enableButtonConfirm.isClosed) _enableButtonConfirm.add(false);
    }
  }

  void updateStatePassword(bool current) {
    if (!_obscureText1Value.isClosed) _obscureText1Value.add(!current);
  }

  void updateStateRepeatPassword(bool current) {
    if (!_obscureText2Value.isClosed) _obscureText2Value.add(!current);
  }

  Future<bool> userResetPassword(String token) async{
    if (!_progressIndicatorValue.isClosed) _progressIndicatorValue.add(true);
    try {
      await _apiAuth.userResetPassword(_passwordValue.valueWrapper.value, token);
      if (!_progressIndicatorValue.isClosed) _progressIndicatorValue.add(false);
      AppToast.showSuccess("Thành công");
      return true;
    } catch (e) {
      if (!_progressIndicatorValue.isClosed) _progressIndicatorValue.add(false);
      AppToast.showError(Utils.getMessageError(e));
      return false;
    }
  }


  @override
  void dispose() {
    _progressIndicatorValue?.close();
    _enableButtonConfirm?.close();
    _passwordValue?.close();
    _obscureText1Value?.close();
    _obscureText2Value?.close();
    _repeatPasswordValue?.close();
  }
}
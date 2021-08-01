import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:t4edu_source_source/base/bloc_base.dart';
import 'package:t4edu_source_source/data/repository/auth_repository.dart';
import 'package:t4edu_source_source/global/app_toast.dart';
import 'package:t4edu_source_source/helpers/Utils.dart';

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

  final BehaviorSubject<bool> _enableButtonFind =
  BehaviorSubject.seeded(false);
  Stream<bool> get enableButtonFindStream => _enableButtonFind.stream;
  Sink<bool> get enableButtonFindSink => _enableButtonFind.sink;

  void updateStateButton() {
    if (_usernameValue.valueWrapper.toString() != "") {
      if (!_enableButtonFind.isClosed) _enableButtonFind.add(true);
    } else {
      if (!_enableButtonFind.isClosed) _enableButtonFind.add(false);
    }
  }

  Future<bool> userForgotPassword() async{
    if (!_progressIndicatorValue.isClosed) _progressIndicatorValue.add(true);

    try {
      await _apiAuth.userForgotPassword(
        _usernameValue.valueWrapper.value
      );
      if (!_progressIndicatorValue.isClosed) _progressIndicatorValue.add(false);
      AppToast.showSuccess("Mã OTP đã được gửi đến");
      return true;
    }
    catch (e) {
      if (!_progressIndicatorValue.isClosed) _progressIndicatorValue.add(false);
      AppToast.showError(Utils.getMessageError(e));
      return false;
    }
  }

  @override
  void dispose() {
    _progressIndicatorValue?.close();
    _enableButtonFind?.close();
    _usernameValue?.close();
  }
}
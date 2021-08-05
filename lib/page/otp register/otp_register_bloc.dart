import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:t4edu_source_source/base/bloc_base.dart';
import 'package:t4edu_source_source/data/repository/auth_repository.dart';
import 'package:t4edu_source_source/global/app_toast.dart';
import 'package:t4edu_source_source/helpers/Utils.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';

class OTPRegisterBloc extends BlocBase {
  final AuthRepositoryIml _apiAuth = GetIt.I<AuthRepositoryIml>();

  OTPRegisterBloc() {
    _bind();
  }

  @override
  void init() async {
    super.init();
    isCountingToResend.add(true);
  }

  void _bind() {}

  final BehaviorSubject<bool> isCountingToResend = BehaviorSubject.seeded(true);
  Sink<bool> get isCountingToResendSink => isCountingToResend.sink;
  Stream<bool> get isCountingTtoResendStream => isCountingToResend.stream;

  Future<bool> resendOTP(String emailOrPhone)async{
    try {
      await _apiAuth.resendOTP(emailOrPhone);
      AppToast.showSuccess(LocaleKeys.resendOtpSuccessMessage.tr());
      return true;
    } catch (e) {
      AppToast.showError(Utils.getMessageError(e));
      return false;
    }
  }

  Future<bool> registerConfirm(String emailOrPhone,String code)async{
    try {
       await _apiAuth.otpRegisterConfirm(
          emailOrPhone, code);
       AppToast.showSuccess(LocaleKeys.success.tr());
       return true;
    } catch (e) {
      print(Utils.getMessageError(e));
      AppToast.showError(Utils.getMessageError(e));
      return false;
    }
  }

  @override
  void dispose() {
    isCountingToResend.close();
  }
}

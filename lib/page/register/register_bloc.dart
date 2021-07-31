import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:t4edu_source_source/base/bloc_base.dart';
import 'package:t4edu_source_source/data/repository/auth_repository.dart';
import 'package:t4edu_source_source/global/app_toast.dart';
import 'package:t4edu_source_source/helpers/Utils.dart';
import 'package:t4edu_source_source/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterBloc extends BlocBase {
  final AuthRepositoryIml _apiAuth = GetIt.I<AuthRepositoryIml>();

  RegisterBloc() {
    _bind();
  }

  @override
  void init() async {
    super.init();
    enableRegisterButton.add(false);
    hasShownPass.add(true);
    isCheckValue.add(false);
    isWaitingRegister.add(false);
  }

  void _bind() {}

  final BehaviorSubject<bool> enableRegisterButton =
  BehaviorSubject.seeded(false);

  Sink<bool> get enableRegisterButtonSink => enableRegisterButton.sink;

  Stream<bool> get enableRegisterButtonStream => enableRegisterButton.stream;

  final BehaviorSubject<bool> hasShownPass = BehaviorSubject.seeded(true);

  Sink<bool> get obscurePassSink => hasShownPass.sink;

  Stream<bool> get obscurePassStream => hasShownPass.stream;

  final BehaviorSubject<String> _emailOrPhoneValue = BehaviorSubject();

  Sink<String> get emailOrPhoneValueSink => _emailOrPhoneValue.sink;

  Stream<String> get emailOrPhoneValueStream => _emailOrPhoneValue.stream;

  final BehaviorSubject<String> _firstNameValue = BehaviorSubject();

  Sink<String> get firstNameValueSink => _firstNameValue.sink;

  Stream<String> get firstNameValueStream => _firstNameValue.stream;

  final BehaviorSubject<String> _lastNameValue = BehaviorSubject();

  Sink<String> get lastNameValueSink => _lastNameValue.sink;

  Stream<String> get lastNameValueStream => _lastNameValue.stream;

  final BehaviorSubject<String> _registeredPassValue = BehaviorSubject();

  Sink<String> get registeredPassValueSink => _registeredPassValue.sink;

  Stream<String> get registeredPassValueStream => _registeredPassValue.stream;

  final BehaviorSubject<String> _rePassValue = BehaviorSubject();

  Sink<String> get rePassValueSink => _rePassValue.sink;

  Stream<String> get rePassValueStream => _rePassValue.stream;

  final BehaviorSubject<bool> isCheckValue = BehaviorSubject.seeded(false);

  Sink<bool> get isCheckValueSink => isCheckValue.sink;

  Stream<bool> get isCheckValueStream => isCheckValue.stream;

  final BehaviorSubject<bool> isWaitingRegister = BehaviorSubject.seeded(false);

  Sink<bool> get isWaitingRegisterSink => isWaitingRegister.sink;

  Stream<bool> get isWaitingRegisterStream => isWaitingRegister.stream;

  void updateObscureState(bool current) {
    obscurePassSink.add(!current);
  }

  bool isCheck;

  void updateCheckBox(bool current) {
    isCheck = current;
    isCheckValueSink.add(current);
  }

  Future<String> registerAccount() async {
    isWaitingRegister.add(true);
    if (isCheck == false) {
      isWaitingRegister.add(false);
      AppToast.showError(LocaleKeys.acceptTheTermsMessage.tr());
      return null;
    } else {
      if (_emailOrPhoneValue.valueWrapper.toString() == "" ||
          _firstNameValue.valueWrapper.toString() == "" ||
          _lastNameValue.valueWrapper.toString() == "" ||
          _registeredPassValue.valueWrapper.toString() == "" ||
          _rePassValue.valueWrapper.toString() == "") {
        isWaitingRegister.add(false);
        AppToast.showError(LocaleKeys.emptyTheFieldMessage.tr());
        return null;
      } else {
        if (_registeredPassValue.valueWrapper.value !=
            _rePassValue.valueWrapper.value) {
          isWaitingRegister.add(false);
          AppToast.showError(LocaleKeys.rePassMessage.tr());
          return null;
        } else {
          try {
            //success
            final dynamic registerResponse = await _apiAuth.registerAccount(
              _emailOrPhoneValue.valueWrapper.value,
              _firstNameValue.valueWrapper.value,
              _lastNameValue.valueWrapper.value,
              _registeredPassValue.valueWrapper.value,
            );
            String emailOrPhoneNumber =
            registerResponse['emailOrPhoneNumber'].toString();
            if (emailOrPhoneNumber != null) {
              isWaitingRegister.add(false);
              AppToast.showSuccess(LocaleKeys.success);
              return emailOrPhoneNumber;
            }
          } catch (e) {
            //error from reposity
            isWaitingRegister.add(false);
            AppToast.showError(Utils.getMessageError(e));
            return null;
          }
        }
      }
    }
  }

  void updateButtonState() {
    if (_emailOrPhoneValue.valueWrapper.toString() != "" &&
        _firstNameValue.valueWrapper.toString() != "" &&
        _lastNameValue.valueWrapper.toString() != "" &&
        _registeredPassValue.valueWrapper.toString() != "" &&
        _rePassValue.valueWrapper.toString() != "") {
      enableRegisterButton.add(true);
    } else
      enableRegisterButton.add(false);
  }

  @override
  void dispose() {
    enableRegisterButton.close();
    _emailOrPhoneValue.close();
    _firstNameValue.close();
    _lastNameValue.close();
    _registeredPassValue.close();
    hasShownPass.close();
    _rePassValue.close();
    isCheckValue.close();
    isWaitingRegister.close();
  }
}

import 'dart:collection';

import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:t4edu_source_source/base/bloc_base.dart';
import 'package:t4edu_source_source/data/repository/auth_repository.dart';

enum OTPValidator{
  Validated,
  Unvalidated,
  Empty
}

class ConfirmOTPBloc extends BlocBase {
  final AuthRepositoryIml _apiAuth = GetIt.I<AuthRepositoryIml>();
  ConfirmOTPBloc() {
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

  final BehaviorSubject<OTPValidator> _otpValidateValue =
  BehaviorSubject.seeded(OTPValidator.Empty);
  Stream<OTPValidator> get otpValidateValueStream => _otpValidateValue.stream;
  Sink<OTPValidator> get otpValidateValueSink => _otpValidateValue.sink;

  final BehaviorSubject<bool> _enableButtonConfirm =
  BehaviorSubject.seeded(false);
  Stream<bool> get enableButtonConfirmStream => _enableButtonConfirm.stream;
  Sink<bool> get enableButtonConfirmSink => _enableButtonConfirm.sink;

  ///pin
  final BehaviorSubject<String> _pinValue = BehaviorSubject();
  Sink<String> get pinValueSink => _pinValue.sink;

  final BehaviorSubject<String> _pin2Value = BehaviorSubject();
  Sink<String> get pin2ValueSink => _pin2Value.sink;

  final BehaviorSubject<String> _pin3Value = BehaviorSubject();
  Sink<String> get pin3ValueSink => _pin3Value.sink;

  final BehaviorSubject<String> _pin4Value = BehaviorSubject();
  Sink<String> get pin4ValueSink => _pin4Value.sink;

  final BehaviorSubject<String> _pin5Value = BehaviorSubject();
  Sink<String> get pin5ValueSink => _pin5Value.sink;

  final BehaviorSubject<String> _pin6Value = BehaviorSubject();
  Sink<String> get pin6ValueSink => _pin6Value.sink;



  void updateStateValidate() {
    if(_pinValue.valueWrapper != null &&
        _pin2Value.valueWrapper != null &&
        _pin3Value.valueWrapper != null &&
        _pin4Value.valueWrapper != null &&
        _pin5Value.valueWrapper != null &&
        _pin6Value.valueWrapper != null) {
      if(!_enableButtonConfirm.isClosed) _enableButtonConfirm.add(true);
      if(!_otpValidateValue.isClosed) _otpValidateValue?.add(OTPValidator.Validated);
    }
    else if(_pinValue.valueWrapper == null &&
        _pin2Value.valueWrapper == null &&
        _pin3Value.valueWrapper == null &&
        _pin4Value.valueWrapper == null &&
        _pin5Value.valueWrapper == null &&
        _pin6Value.valueWrapper == null){
      if(!_otpValidateValue.isClosed) _otpValidateValue?.add(OTPValidator.Empty);
      if(!_enableButtonConfirm.isClosed) _enableButtonConfirm.add(false);
    }
    else{
      if(!_otpValidateValue.isClosed) _otpValidateValue?.add(OTPValidator.Unvalidated);
      if(!_enableButtonConfirm.isClosed) _enableButtonConfirm.add(false);
    }
  }


  @override
  void dispose() {
    _progressIndicatorValue?.close();
    _enableButtonConfirm?.close();
    _pinValue?.close();
    _pin2Value?.close();
    _pin3Value?.close();
    _pin4Value?.close();
    _pin5Value?.close();
    _pin6Value?.close();
    _otpValidateValue?.close();
  }
}
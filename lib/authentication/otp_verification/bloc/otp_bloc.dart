import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_login_example/authentication/otp_verification/models/otp_code.dart';
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const OtpState()) {
    on<OTPCodeChanged>(_onOtpCodeChanged);
    on<OTPReSendSubmitted>(_onReSendSubmitted);
    on<OTPSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onOtpCodeChanged(
    OTPCodeChanged event,
    Emitter<OtpState> emit,
  ) {
    final otpCode = (event.otpCode);
    if(otpCode==""){
      emit(state.copyWith(
        otpCode: OTPCode(otpCode: otpCode, status: FormStatus.valid, errorMessage: ""),
        status: FormStatus.valid,
      ));
    }
    else if (_authenticationRepository.isNumeric(otpCode)) {
      emit(state.copyWith(
        otpCode: OTPCode(otpCode: otpCode, status: FormStatus.valid, errorMessage: ""),
        status: FormStatus.valid,
      ));
    }
    else{
      emit(state.copyWith(
        otpCode: OTPCode(otpCode: otpCode, status: FormStatus.notANumber,
            errorMessage: "Sadece numerik karakterler girilebilir."),
        status: FormStatus.valid,
      ));
    }

  }

  void _onReSendSubmitted(
    OTPReSendSubmitted event,
    Emitter<OtpState> emit,
  ) {}

  void _onSubmitted(
    OTPSubmitted event,
    Emitter<OtpState> emit,
  ) {}
}

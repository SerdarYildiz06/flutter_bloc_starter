import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_login_example/authentication/phone_register/models/phone_number.dart';
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';
import 'package:formz/formz.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required AuthenticationRepository authenticationRepository,
  })
      : _authenticationRepository = authenticationRepository,
        super(const ForgotPasswordState()) {
    on<ForgotPasswordPhoneNumberChanged>(_onPhoneNumberChanged);
    on<ForgotPasswordSubmitted>(_onSubmitted);
    on<LoginRequestSubmitted>(_onLoginRequestSubmitted);
    on<RegisterRequestSubmitted>(_onRegisterRequestSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onPhoneNumberChanged(ForgotPasswordPhoneNumberChanged event,
      Emitter<ForgotPasswordState> emit,) {
    final phoneNumber = event.phoneNumber;
    debugPrint("_onPhoneNumberChanged");

    emit(state.copyWith(phoneNumber: PhoneNumberLocal(phoneNumber: phoneNumber!,
        status: FormStatus.valid, errorMessage: "")
        , status: event.isValid == true ? FormzStatus.valid : FormzStatus.invalid),);
  }

  void _onSubmitted(ForgotPasswordSubmitted event,
      Emitter<ForgotPasswordState> emit,) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        _authenticationRepository.sendOTP(phoneNumber: state.phoneNumber.phoneNumber);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void _onLoginRequestSubmitted(LoginRequestSubmitted event,
      Emitter<ForgotPasswordState> emit,) async {
    await _authenticationRepository.changingState(
      status: AuthenticationStatus.unauthenticated,
      prev: AuthenticationStatus.activationNone,
    );
  }

  void _onRegisterRequestSubmitted(RegisterRequestSubmitted event,
      Emitter<ForgotPasswordState> emit,) async {
    await _authenticationRepository.changingState(
      status: AuthenticationStatus.signUp,
      prev: AuthenticationStatus.activationNone,
    );
  }
}

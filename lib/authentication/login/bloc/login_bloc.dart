import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_login_example/authentication/login/models/password.dart';
import 'package:flutter_bloc_login_example/authentication/login/models/username.dart';
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';
import 'package:formz/formz.dart';

import '../../../repositories/models/user.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<ForgotPasswordRequestSubmitted>(_onForgotPasswordSubmitted);
    on<RegisterRequestFromLoginSubmitted>(_onRegisterSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = (event.username);
    emit(state.copyWith(
      username: Username(
          username: username, status: FormStatus.valid, errorMessage: ""),
      status: FormStatus.valid,
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = (event.password);
    emit(state.copyWith(
      password: Password(
          password: password, status: FormStatus.valid, errorMessage: ""),
      status: FormStatus.valid,
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      User user = await _authenticationRepository.logIn(
        username: state.username.username,
        password: state.password.password,
      );
      if (user.name == null) {
        emit(state.copyWith(status: FormStatus.wrongAuthentication));
      }
      emit(state.copyWith(status: FormStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }

  void _onForgotPasswordSubmitted(
    ForgotPasswordRequestSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    await _authenticationRepository.changingState(
        status: AuthenticationStatus.activationNone,
        prev: AuthenticationStatus.unauthenticated);
  }

  void _onRegisterSubmitted(
    RegisterRequestFromLoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    await _authenticationRepository.changingState(
        status: AuthenticationStatus.signUp,
        prev: AuthenticationStatus.unauthenticated);
  }
}

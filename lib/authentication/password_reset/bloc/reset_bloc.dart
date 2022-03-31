import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_login_example/authentication/login/models/password.dart';
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';

part 'reset_event.dart';

part 'reset_state.dart';

class ResetBloc extends Bloc<ResetEvent, ResetState> {
  ResetBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const ResetState()) {
    on<ResetPasswordPasswordChanged>(_onPasswordChanged);
    on<ResetPasswordRePasswordChanged>(_onRePasswordChanged);
    on<ResetPasswordSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onPasswordChanged(
    ResetPasswordPasswordChanged event,
    Emitter<ResetState> emit,
  ) {
    final password = event.password;
    if (password.isEmpty) {
      emit(state.copyWith(
        password: Password(password: password, status: FormStatus.valid, errorMessage: ""),
        status: FormStatus.valid,
      ));
    } else {
      String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.'
          r'*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      RegExp regExp = RegExp(pattern);
      bool isValid = regExp.hasMatch(password);
      emit(state.copyWith(
        password: Password(password: password, status: isValid ? FormStatus.valid : FormStatus.invalid, errorMessage: "Şifreniz gerekli güvenliği sağlamıyor."),
        status: FormStatus.invalid,
      ));
    }
  }

  void _onRePasswordChanged(
    ResetPasswordRePasswordChanged event,
    Emitter<ResetState> emit,
  ) {
    final repassword = event.repassword;
    if (repassword == state.password.password) {
      emit(state.copyWith(repassword: Password(password: repassword, status: FormStatus.valid, errorMessage: ""), status: FormStatus.valid));
    } else {
      emit(state.copyWith(
          repassword: Password(password: repassword, status: FormStatus.invalid, errorMessage: "Şifreler birbirleriyle uyuşmamaktadır."), status: FormStatus.invalid));
    }
  }

  void _onSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetState> emit,
  ) async {
    if (state.status == FormStatus.valid) {
      emit(state.copyWith(status: FormStatus.submissionInProgress));
      try {
        emit(state.copyWith(status: FormStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormStatus.submissionFailure));
      }
    }
  }
}

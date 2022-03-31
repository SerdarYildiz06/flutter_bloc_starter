import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_login_example/authentication/login/models/password.dart';
import 'package:flutter_bloc_login_example/authentication/login/models/username.dart';
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const RegisterState()) {
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterRePasswordChanged>(_onRePasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
    on<LoginRequestFromRegisterSubmitted>(_onLoginRequestSubmitted);

  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    RegisterUsernameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = (event.username);
    emit(state.copyWith(username: Username(username: username, status: FormStatus.valid, errorMessage: ""), status: FormStatus.invalid));
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
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
    RegisterRePasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final repassword = event.repassword;
    if (repassword == state.password.password) {
      emit(state.copyWith(
          repassword: Password(password: repassword,
              status: FormStatus.valid, errorMessage: ""),
          status:  FormStatus.valid));
    }
    else{
      emit(state.copyWith(
          repassword: Password(password: repassword,
              status: FormStatus.invalid,
              errorMessage: "Şifreler birbirleriyle uyuşmamaktadır."),
          status:  FormStatus.invalid));
    }
  }

  void _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.status == FormStatus.valid) {
      emit(state.copyWith(status: FormStatus.submissionInProgress));
      try {
        await _authenticationRepository.logIn(
          username: state.username.username,
          password: state.password.password,
        );
        emit(state.copyWith(status: FormStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormStatus.submissionFailure));
      }
    }
  }
  void _onLoginRequestSubmitted(
      LoginRequestFromRegisterSubmitted event,
      Emitter<RegisterState> emit,
      ) async {
    await _authenticationRepository.changingState(status: AuthenticationStatus.unauthenticated,
        prev: AuthenticationStatus.signUp);
  }

}

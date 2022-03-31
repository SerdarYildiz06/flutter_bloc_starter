part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUsernameChanged extends RegisterEvent {
  const RegisterUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterRePasswordChanged extends RegisterEvent {
  const RegisterRePasswordChanged(this.repassword);

  final String repassword;

  @override
  List<Object> get props => [repassword];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}

class LoginRequestFromRegisterSubmitted extends RegisterEvent {
  const LoginRequestFromRegisterSubmitted(this.previousState);

  final AuthenticationStatus previousState;
  @override
  List<Object> get props => [previousState];
}

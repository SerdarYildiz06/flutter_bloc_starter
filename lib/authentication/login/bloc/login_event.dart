part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterRequestFromLoginSubmitted extends LoginEvent {
  const RegisterRequestFromLoginSubmitted(this.previousState);

  final AuthenticationStatus previousState;

  @override
  List<Object> get props => [previousState];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class ForgotPasswordRequestSubmitted extends LoginEvent {
  const ForgotPasswordRequestSubmitted(this.previousState);

  final AuthenticationStatus previousState;

  @override
  List<Object> get props => [previousState];
}

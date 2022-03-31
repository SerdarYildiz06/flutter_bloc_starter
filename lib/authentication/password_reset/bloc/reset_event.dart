part of 'reset_bloc.dart';

@immutable
abstract class ResetEvent extends Equatable {
  const ResetEvent();

  @override
  List<Object> get props => [];
}

class ResetPasswordPasswordChanged extends ResetEvent {
  const ResetPasswordPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class ResetPasswordRePasswordChanged extends ResetEvent {
  const ResetPasswordRePasswordChanged(this.repassword);

  final String repassword;

  @override
  List<Object> get props => [repassword];
}

class ResetPasswordSubmitted extends ResetEvent {
  const ResetPasswordSubmitted();
}
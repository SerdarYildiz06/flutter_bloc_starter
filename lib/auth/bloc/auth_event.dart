part of 'auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}
class AuthenticationStatusBackward extends AuthenticationEvent {
  const AuthenticationStatusBackward (this.prevStatus);
  final AuthenticationStatus prevStatus;




  @override
  List<Object> get props => [prevStatus];

}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

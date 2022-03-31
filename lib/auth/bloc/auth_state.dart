part of 'auth_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.activationNone()
      : this._(status: AuthenticationStatus.activationNone);
  const AuthenticationState.signUp()
      : this._(status: AuthenticationStatus.signUp);
  const AuthenticationState.activationWaitingCodeFromUser()
      : this._(status: AuthenticationStatus.activationWaitingCodeFromUser);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}


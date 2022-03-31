part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormStatus.pure,
    this.username = const Username(
      username: "",
      status: FormStatus.valid,
      errorMessage: "",
    ),
    this.password = const Password(
      password: "",
      status: FormStatus.valid,
      errorMessage: "",
    ),
  });

  final FormStatus status;
  final Username username;
  final Password password;

  LoginState copyWith({
    FormStatus? status,
    Username? username,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}

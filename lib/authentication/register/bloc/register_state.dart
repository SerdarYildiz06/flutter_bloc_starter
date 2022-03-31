part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormStatus.pure,
    this.username = const Username(username: "", status: FormStatus.valid, errorMessage: ""),
    this.password = const Password(password: "", status: FormStatus.valid, errorMessage: ""),
    this.repassword = const Password(password: "", status: FormStatus.valid, errorMessage: ""),
  });

  final FormStatus status;
  final Username username;
  final Password password;
  final Password repassword;

  RegisterState copyWith({
    required FormStatus status,
    Username? username,
    Password? password,
    Password? repassword,
  }) {
    return RegisterState(
      status: status,
      username: username ?? this.username,
      password: password ?? this.password,
      repassword: repassword ?? this.repassword,
    );
  }

  @override
  List<Object> get props => [status, username, password, repassword];
}

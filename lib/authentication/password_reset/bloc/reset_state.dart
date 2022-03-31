part of 'reset_bloc.dart';

class ResetState extends Equatable {
  const ResetState({
    this.status = FormStatus.pure,
    this.password = const Password(password: "", status: FormStatus.valid, errorMessage: ""),
    this.repassword = const Password(password: "", status: FormStatus.valid, errorMessage: ""),
  });

  final FormStatus status;
  final Password password;
  final Password repassword;

  ResetState copyWith({
    required FormStatus status,
    Password? password,
    Password? repassword,
  }) {
    return ResetState(
      status: status,
      password: password ?? this.password,
      repassword: repassword ?? this.repassword,
    );
  }

  @override
  List<Object> get props => [status, password, repassword];
}

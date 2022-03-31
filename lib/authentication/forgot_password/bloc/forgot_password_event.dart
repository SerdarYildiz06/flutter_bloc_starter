part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordPhoneNumberChanged extends ForgotPasswordEvent {
  const ForgotPasswordPhoneNumberChanged(this.phoneNumber,this.isValid);

  final String? phoneNumber;
  final bool? isValid;

  @override
  List<Object> get props => [phoneNumber!,isValid!];
}


class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  const ForgotPasswordSubmitted();
}class LoginRequestSubmitted extends ForgotPasswordEvent {
  const LoginRequestSubmitted(this.previousState);

  final AuthenticationStatus previousState;
  @override
  List<Object> get props => [previousState];
}
class RegisterRequestSubmitted extends ForgotPasswordEvent {
  const RegisterRequestSubmitted(this.previousState);

  final AuthenticationStatus previousState;
  @override
  List<Object> get props => [previousState];

}

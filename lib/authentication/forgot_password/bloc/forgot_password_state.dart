part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState(
      {this.status = FormzStatus.pure, this.phoneNumber = const PhoneNumberLocal(phoneNumber: "", errorMessage: "", status: FormStatus.valid), this.isValid = false});

  final FormzStatus status;
  final PhoneNumberLocal phoneNumber;
  final bool isValid;

  ForgotPasswordState copyWith({
    FormzStatus? status,
    PhoneNumberLocal? phoneNumber,
    bool? isValid,
  }) {
    debugPrint("ForgotPasswordState");
    return ForgotPasswordState(status: status ?? this.status, phoneNumber: phoneNumber ?? this.phoneNumber, isValid: this.isValid);
  }

  @override
  List<Object> get props => [status, phoneNumber];
}

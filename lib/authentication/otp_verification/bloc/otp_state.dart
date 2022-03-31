part of 'otp_bloc.dart';

class OtpState extends Equatable {
  const OtpState({
    this.status = FormStatus.pure,
    this.otpCode = const OTPCode(otpCode: "", status: FormStatus.valid, errorMessage: ""),
  });

  final FormStatus status;
  final OTPCode otpCode;

  OtpState copyWith({
    required FormStatus status,
    OTPCode? otpCode,
  }) {
    return OtpState(
      status: status,
      otpCode: otpCode!,
    );
  }

  @override
  List<Object> get props => [status, otpCode];
}

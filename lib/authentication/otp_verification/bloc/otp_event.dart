part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}
class OTPCodeChanged extends OtpEvent {
  const OTPCodeChanged(this.otpCode);

  final String otpCode;

  @override
  List<Object> get props => [otpCode];
}

class OTPSubmitted extends OtpEvent {
  const OTPSubmitted();
}
class OTPReSendSubmitted extends OtpEvent {
  const OTPReSendSubmitted();
}

part of 'phone_register_bloc.dart';

abstract class PhoneRegisterEvent extends Equatable {
  const PhoneRegisterEvent();

  @override
  List<Object> get props => [];
}

class PhoneRegisterPhoneNumberChanged extends PhoneRegisterEvent {
  const PhoneRegisterPhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}


class PhoneRegisterPhoneNumberSubmitted extends PhoneRegisterEvent {
  const PhoneRegisterPhoneNumberSubmitted();
}

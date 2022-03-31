part of 'phone_register_bloc.dart';

class PhoneRegisterState extends Equatable {
  const PhoneRegisterState({
    this.status = FormStatus.pure,
    this.phoneNumber = const PhoneNumberLocal(
      phoneNumber: "",
      status: FormStatus.valid,
      errorMessage: "",
    ),
  });

  final FormStatus status;
  final PhoneNumberLocal phoneNumber;

  PhoneRegisterState copyWith({
    FormStatus? status,
    PhoneNumberLocal? phoneNumber,
  }) {
    return PhoneRegisterState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object> get props => [status, phoneNumber];
}

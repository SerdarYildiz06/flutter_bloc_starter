import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_login_example/authentication/phone_register/models/phone_number.dart';
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';
import 'package:flutter_bloc_login_example/repositories/authentication_repository.dart';


part 'phone_register_event.dart';

part 'phone_register_state.dart';

class PhoneRegisterBloc extends Bloc<PhoneRegisterEvent, PhoneRegisterState> {
  PhoneRegisterBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const PhoneRegisterState()) {
    on<PhoneRegisterPhoneNumberChanged>(_onPhoneNumberChanged);
    on<PhoneRegisterPhoneNumberSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onPhoneNumberChanged(
    PhoneRegisterPhoneNumberChanged event,
    Emitter<PhoneRegisterState> emit,
  ) {
    final phoneNumber = (event.phoneNumber);
    emit(state.copyWith(
      phoneNumber: PhoneNumberLocal(phoneNumber: phoneNumber, status: FormStatus.valid, errorMessage: ""),
      status: FormStatus.valid,
    ));
  }

  void _onSubmitted(
    PhoneRegisterPhoneNumberSubmitted event,
    Emitter<PhoneRegisterState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      //TODO : Phonenumber verification
      emit(state.copyWith(status: FormStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }
}

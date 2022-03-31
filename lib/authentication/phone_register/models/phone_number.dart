


import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';

class PhoneNumberLocal {
  final String phoneNumber;
  final String errorMessage;
  final FormStatus status;

  const PhoneNumberLocal({required this.phoneNumber,
    required this.status, required this.errorMessage});


}
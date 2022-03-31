
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';

class OTPCode {
  final String otpCode;
  final String errorMessage;
  final FormStatus status;

  const OTPCode({required this.otpCode,
    required this.status, required this.errorMessage});
}

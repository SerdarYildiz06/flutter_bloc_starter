
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';

class Password {
  final String password;
  final String errorMessage;
  final FormStatus status;

  const Password({required this.password,
    required this.status, required this.errorMessage});
}

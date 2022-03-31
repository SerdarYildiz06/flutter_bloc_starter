
import 'package:flutter_bloc_login_example/authentication/register/models/enums.dart';

class Username {
  final String username;
  final String errorMessage;
  final FormStatus status;

  const Username({required this.username, required this.status, required this.errorMessage});
}

import 'dart:async';

import 'package:uuid/uuid.dart';

import 'models/models.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = const User(
          id: Uuid(),
          name: "Serdar",
          surname: "Yıldız",
          mail: "serdaryildiz43@hotmail.com",
          password: "123",
          phoneNumber: "05",
          status: 0,
          mode: 0),
    );
  }
}

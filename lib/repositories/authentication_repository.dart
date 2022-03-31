import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../dio/dio_base.dart';
import 'models/user.dart';

enum AuthenticationStatus {
  none,
  unknown,
  signUp,
  signUpFail,
  activationNone,
  activationWaitingCodeFromUser,
  activationReSendNeeded,
  activationSuccess,
  activationFail,
  activationFailCodeMismatch,
  activationFailCodeTimeOut,
  loginNone,
  login,
  loginFail,
  readyUpContactSync,
  readyUpContactSyncFail,
  readyUpChatSessionsSyncFail,
  readyUpCsppNone,
  readyUpCsppUnknownContactsSync,
  readyUpCsspRccgSync,
  readyUpCsppUnreadMessagesSync,
  readyUpCsppUnreadMessagesSyncFail,
  readyUpCsppProcessUnreadMessages,
  readyUpCsppProcessUnreadMessagesFail,
  ready,
  logout,
  authenticated,
  unVerified,
  unauthenticated
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final List<AuthenticationStatus> _states = [];

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    _states.add(AuthenticationStatus.unauthenticated);
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<User> logIn({
    required String username,
    required String password,
  }) async {
    User user = User(mail: username, password: password);
    try {
      var userLoginResponse = await DioBase().loginUser(user);
      if (userLoginResponse == "0") {
        _controller.add(AuthenticationStatus.unauthenticated);
        return const User();
      } else {
        debugPrint("Success");
        _controller.add(AuthenticationStatus.authenticated);
        return userLoginResponse;
      }
    } on Exception catch (exception) {
      return const User();
    }
  }

  bool isNumeric(String s) => double.tryParse(s) != null;
  Future<void> sendOTP({
    required String phoneNumber,
  }) async {
    //User user = User(phoneNumber: phoneNumber);
    try {
      //TODO: Redirect to OTP Page
      _controller.add(AuthenticationStatus.activationWaitingCodeFromUser);
    } on Exception catch (exception) {
      debugPrint('Reached => ' + exception.toString());
    }
  }

  Future<void> changingState({
    required AuthenticationStatus prev,
    required AuthenticationStatus status,
  }) async {
    try {
      _controller.add(status);
      _states.add(status);
    } on Exception catch (exception) {
      debugPrint('Reached => ' + exception.toString());
    }
  }

  Future<void> changingBack({required AuthenticationStatus prevStatus}) async {
    try {
      _states.removeLast();
      _controller.add(_states[_states.length - 1]);
    } on Exception catch (exception) {
      debugPrint('Reached => ' + exception.toString());
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

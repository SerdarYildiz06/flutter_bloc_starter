import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../repositories/models/user.dart';

part 'home_event.dart';

part 'home_state.dart';
/*
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required ModuleRepository moduleRepository,
  })  : _moduleRepository = moduleRepository,
        super(const HomeState(0)) {
    on<NotificationCountChanged>(_onNotificationCountChanged);
    /*on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<ForgotPasswordRequestSubmitted>(_onForgotPasswordSubmitted);
    on<RegisterRequestFromLoginSubmitted>(_onRegisterSubmitted);*/
  }

  final ModuleRepository _moduleRepository;

  void _onNotificationCountChanged(
    NotificationCountChanged event,
    Emitter<HomeState> emit,
  ) {
    final notificationCount = (event.notificationCount);
    emit(state.copyWith(
      notificationCount: notificationCount,
    ));
  }
}
*/
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class NotificationCountChanged extends HomeEvent {
  const NotificationCountChanged(this.notificationCount);

  final int notificationCount;

  @override
  List<Object> get props => [notificationCount];
}


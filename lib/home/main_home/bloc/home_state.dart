part of 'home_bloc.dart';

class HomeState extends Equatable {

  final int notificationCount;
  const HomeState(this.notificationCount);


  HomeState copyWith({int? notificationCount}){
    return HomeState(notificationCount ?? this.notificationCount);
  }
  @override
  List<Object> get props => [notificationCount];
}

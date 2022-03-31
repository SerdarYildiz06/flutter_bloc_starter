part of 'page_bloc.dart';

@immutable
abstract class PageEvent extends Equatable{
  const PageEvent();
  @override
  List<Object> get props => [];
}

class PageIndexChanged extends PageEvent{
  const PageIndexChanged(this.currentIndex);

  final int currentIndex;

  @override
  List<Object> get props => [currentIndex];
}

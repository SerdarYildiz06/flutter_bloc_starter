part of 'page_bloc.dart';

class PageState extends Equatable {
  const PageState({this.currentIndex = 0, this.status = FormStatus.pure});

  final int currentIndex;
  final FormStatus status;
  PageState copyWith({
    FormStatus? status,
     int? currentIndex,
  }) {
    return PageState(
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [status,currentIndex];
}

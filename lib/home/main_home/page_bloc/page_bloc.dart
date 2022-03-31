import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../authentication/register/models/enums.dart';

part 'page_event.dart';

part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(const PageState()) {
    on<PageIndexChanged>(_onPageIndexChanged);
  }

  void _onPageIndexChanged(
    PageIndexChanged event,
    Emitter<PageState> emit,
  ) async {
    final currentIndex = (event.currentIndex);
    emit(state.copyWith(
        status: FormStatus.submissionInProgress, currentIndex: currentIndex));
    try {

      emit(state.copyWith(
          status: FormStatus.submissionSuccess, currentIndex: currentIndex));
    } on Exception {
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }
}

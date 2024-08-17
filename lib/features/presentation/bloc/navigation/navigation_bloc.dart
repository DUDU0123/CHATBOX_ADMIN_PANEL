import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<NavigateToPageEvent>(navigateToPageEvent);
  }

  FutureOr<void> navigateToPageEvent(NavigateToPageEvent event, Emitter<NavigationState> emit) {
    try {
      emit(NavigationState(currentIndex: event.currentIndex));
    } catch (e) {
      emit(NavigationErrorState(errorMessage: e.toString()));
    }
  }
}

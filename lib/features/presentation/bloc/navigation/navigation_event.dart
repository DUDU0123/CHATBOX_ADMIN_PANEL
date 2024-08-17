part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateToPageEvent extends NavigationEvent {
  final int currentIndex;
  const NavigateToPageEvent({
    required this.currentIndex,
  });
  @override
  List<Object> get props => [currentIndex,];
}

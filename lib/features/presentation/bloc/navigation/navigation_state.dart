part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  const NavigationState({
    this.currentIndex = 0,
  });
  final int? currentIndex;

  @override
  List<Object> get props => [currentIndex??0];
}

final class NavigationInitial extends NavigationState {}
class NavigationErrorState extends NavigationState {
  final String errorMessage;
  const NavigationErrorState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage,];
}

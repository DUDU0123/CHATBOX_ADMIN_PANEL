part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
class GetAllUsersEvent extends UserEvent{}
class GetAllDisabledUsersEvent extends UserEvent{}
class GetAllReportedAccountsEvent extends UserEvent{}
class SearchUsersEvent extends UserEvent {
  final String searchInput;

  const SearchUsersEvent({required this.searchInput});
  @override
  List<Object> get props => [searchInput,];
}
class EnableUserEvent extends UserEvent {
  final String userId;
  const EnableUserEvent({
    required this.userId,
  });
  @override
  List<Object> get props => [userId];
}

class DisableUserEvent extends UserEvent {
  final String userId;
  const DisableUserEvent({
    required this.userId,
  });
  @override
  List<Object> get props => [userId];
}

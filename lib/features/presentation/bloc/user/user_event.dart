part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
class GetAllUsersEvent extends UserEvent{}
class GetAllDisabledUsersEvent extends UserEvent{}
class GetAllReportedAccountsEvent extends UserEvent{}
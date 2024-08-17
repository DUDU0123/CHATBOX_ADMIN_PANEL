part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.usersList,
    this.disabledUsersList,
    this.reportedAccounts,
  });
  final Stream<List<UserModel>>? usersList;
  final Stream<List<UserModel>>? disabledUsersList;
  final Stream<List<UserModel>>? reportedAccounts;
  UserState copyWith({
    Stream<List<UserModel>>? usersList,
    Stream<List<UserModel>>? disabledUsersList,
    Stream<List<UserModel>>? reportedAccounts,
  }) {
    return UserState(
      usersList: usersList ?? this.usersList,
      disabledUsersList: disabledUsersList ?? this.disabledUsersList,
      reportedAccounts: reportedAccounts ?? this.reportedAccounts,
    );
  }

  @override
  List<Object> get props => [
        usersList ?? [],
        disabledUsersList ?? [],
        reportedAccounts ?? [],
      ];
}

final class UserInitial extends UserState {}

class UserErrorState extends UserState {
  final String errorMessage;
  const UserErrorState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [
        errorMessage,
      ];
}

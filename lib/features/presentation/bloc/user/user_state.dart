part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.usersList,
    this.disabledUsersList,
    this.reportedAccounts,
    this.message,
  });
  final Stream<List<UserModel>>? usersList;
  final Stream<List<UserModel>>? disabledUsersList;
  final Stream<List<UserModel>>? reportedAccounts;
  final String? message;
  UserState copyWith({
    Stream<List<UserModel>>? usersList,
    Stream<List<UserModel>>? disabledUsersList,
    Stream<List<UserModel>>? reportedAccounts,
    String? message,
  }) {
    return UserState(
      usersList: usersList ?? this.usersList,
      disabledUsersList: disabledUsersList ?? this.disabledUsersList,
      reportedAccounts: reportedAccounts ?? this.reportedAccounts,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        usersList ?? [],
        disabledUsersList ?? [],
        reportedAccounts ?? [],message??'',
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

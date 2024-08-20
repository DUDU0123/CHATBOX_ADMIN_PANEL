import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:official_chatbox_admin_application/config/all_bloc_provider.dart';
import 'package:official_chatbox_admin_application/core/constants/database_constants.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';
import 'package:official_chatbox_admin_application/features/domain/repositories/user_repo/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({
    required this.userRepository,
  }) : super(UserInitial()) {
    on<GetAllUsersEvent>(getAllUsersEvent);
    on<GetAllDisabledUsersEvent>(getAllDisabledUsersEvent);
    on<GetAllReportedAccountsEvent>(getAllReportedAccountsEvent);
    on<SearchUsersEvent>(searchUsersEvent);
  }

  FutureOr<void> getAllUsersEvent(
      GetAllUsersEvent event, Emitter<UserState> emit) {
    try {
      final Stream<List<UserModel>>? usersList =
          userRepository.getAllUsersInDB();
      log("From bloc userlist : $usersList");
      emit(UserState(usersList: usersList));
    } catch (e) {
      emit(UserErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> getAllDisabledUsersEvent(
      GetAllDisabledUsersEvent event, Emitter<UserState> emit) {
    try {
      final Stream<List<UserModel>>? disabledUsersList =
          userRepository.getAllDisabeledUsersInDB();
      log("From bloc disabled users : $disabledUsersList");
      emit(
        UserState(
          usersList: state.usersList,
          disabledUsersList: disabledUsersList,
        ),
      );
    } catch (e) {
      emit(UserErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> getAllReportedAccountsEvent(
      GetAllReportedAccountsEvent event, Emitter<UserState> emit) {
    try {
      final Stream<List<UserModel>>? reportedAccounts =
          userRepository.getAllReportedAccountsInDB();
      log("From bloc disabled users : $reportedAccounts");
      emit(
        UserState(
          usersList: state.usersList,
          disabledUsersList: state.disabledUsersList,
          reportedAccounts: reportedAccounts,
        ),
      );
    } catch (e) {
      emit(UserErrorState(errorMessage: e.toString()));
    }
  }

Future<void> searchUsersEvent(
  SearchUsersEvent event,
  Emitter<UserState> emit,
) async {
  try {
    final searchStream = fireStore
        .collection(usersCollection)
        .where('name', isGreaterThanOrEqualTo: event.searchInput)
        .where('name', isLessThanOrEqualTo: event.searchInput + '\uf8ff')
        .snapshots();

    // Map the Firestore snapshots into a list of UserModel
    final filteredUserStream = searchStream.map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromJson(map: doc.data()))
          .toList();
    });

    // Emit a new state with the updated stream
    emit(state.copyWith(usersList: filteredUserStream));
  } catch (e) {
    emit(UserErrorState(errorMessage: e.toString()));
  }
}

  }

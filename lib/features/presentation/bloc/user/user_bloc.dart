import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:official_chatbox_admin_application/config/all_bloc_provider.dart';
import 'package:official_chatbox_admin_application/core/constants/database_constants.dart';
import 'package:official_chatbox_admin_application/core/utils/common_db_functions.dart';
import 'package:official_chatbox_admin_application/features/data/models/report_model/report_model.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';
import 'package:official_chatbox_admin_application/features/domain/repositories/user_repo/user_repository.dart';
import 'package:rxdart/rxdart.dart';

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
    on<EnableUserEvent>(enableUserEvent);
    on<DisableUserEvent>(disableUserEvent);
  }

  FutureOr<void> getAllUsersEvent(
      GetAllUsersEvent event, Emitter<UserState> emit) {
    try {
      final Stream<List<UserModel>>? usersList =
          userRepository.getAllUsersInDB();
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
      final Stream<List<ReportModel>>? reportedAccounts =
          userRepository.getAllReportedAccountsFromDB();
      // Transform the reportedAccounts stream into a stream of user models
      final Stream<List<UserModel>>? reportedUserStream =
          reportedAccounts?.asyncMap((reportList) async {
        // Fetch all user models based on reportedUserId in the reportList
        final List<UserModel> users = await Future.wait(
          reportList
              .map((report) async {
                final userStream =
                    CommonDbFunctions.getOneUserDataFromDataBaseAsStream(
                        userId: report.reportedUserId!);

                // Fetch the first event from the user stream and handle null values
                final UserModel? userModel = await userStream.first;

                // Handle the case where userModel might be null
                if (userModel != null) {
                  return userModel;
                } else {
                  throw Exception(
                      "User with ID ${report.reportedUserId} not found.");
                }
              })
              .whereType<Future<UserModel>>()
              .toList(), // Ensure the list contains non-null UserModel futures
        );

        return users;
      });

      emit(
        UserState(
          usersList: state.usersList,
          disabledUsersList: state.disabledUsersList,
          reportedAccounts: reportedUserStream,
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
      final debouncedSearchStream = Rx.timer(
        event.searchInput,
        const Duration(milliseconds: 500),
      ).flatMap((searchInput) {
        final searchStream = fireStore
            .collection(usersCollection)
            .where(userDbName, isGreaterThanOrEqualTo: searchInput)
            .where(userDbName, isLessThanOrEqualTo: searchInput + '\uf8ff')
            .snapshots();

        // Map the Firestore snapshots into a list of UserModel
        final filteredUserStream = searchStream.map((snapshot) {
          return snapshot.docs
              .map((doc) => UserModel.fromJson(map: doc.data()))
              .toList();
        });

        return filteredUserStream;
      });

      emit(state.copyWith(usersList: debouncedSearchStream));
    } catch (e) {
      emit(UserErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> enableUserEvent(
      EnableUserEvent event, Emitter<UserState> emit) async {
    try {
      final value = await userRepository.enableUser(userId: event.userId);
      if (value) {
        emit(state.copyWith(
          message: 'Enabled successfully',
          reportedAccounts: state.reportedAccounts,
          disabledUsersList: state.disabledUsersList,
          usersList: state.usersList,
        ));
      } else {
        emit(const UserErrorState(errorMessage: "Unable to enable user"));
      }
    } catch (e) {
      emit(const UserErrorState(errorMessage: "Something went wrong"));
    }
  }

  Future<FutureOr<void>> disableUserEvent(
      DisableUserEvent event, Emitter<UserState> emit) async {
    try {
      final value = await userRepository.disableUser(userId: event.userId);
      if (value) {
        emit(state.copyWith(
          message: 'Disabled successfully',
          reportedAccounts: state.reportedAccounts,
          disabledUsersList: state.disabledUsersList,
          usersList: state.usersList,
        ));
      } else {
        emit(const UserErrorState(errorMessage: "Unable to disable user"));
      }
    } catch (e) {
      emit(const UserErrorState(errorMessage: "Unable to disable user"));
    }
  }
}

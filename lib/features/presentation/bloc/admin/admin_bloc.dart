import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/utils/common_db_functions.dart';
import 'package:official_chatbox_admin_application/core/utils/common_snackbar_widget.dart';
import 'package:official_chatbox_admin_application/core/utils/pick_file_from_storage.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';
import 'package:official_chatbox_admin_application/features/domain/repositories/admin_repo/admin_repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepository;
  AdminBloc({
    required this.adminRepository,
  }) : super(AdminInitial()) {
    on<AddAdminEvent>(addAdminEvent);
    on<AdminSignInEvent>(adminSignInEvent);
    on<CountrySelectedEvent>(countrySelectedEvent);
    on<EnableUserEvent>(enableUserEvent);
    on<DisableUserEvent>(disableUserEvent);
    on<GetAllAdminsEvent>(getAllAdminsEvent);
    on<ImagePickEvent>(imagePickEvent);
    on<GetCurrentAdminData>(getCurrentAdminData);
    on<CheckIfAdminSignedInEvent>(checkIfAdminSignedInEvent);
    on<GetCurrentAdminNumberEvent>(getCurrentAdminNumberEvent);
    on<UpdateAdminEvent>(updateAdminEvent);
    on<DeleteAdminEvent>(deleteAdminEvent);
  }

  Future<FutureOr<void>> adminSignInEvent(
      AdminSignInEvent event, Emitter<AdminState> emit) async {
    try {
      // RegExp phoneRegExp =
      //     RegExp(r'^\+?(\d{1,3})?[-. ]?(\(?\d{3}\)?)[-. ]?\d{3}[-. ]?\d{4}$');
      // if (phoneRegExp.hasMatch(event.phoneNumber)) {
      final value = await adminRepository.signInWithPhoneNumber(
        context: event.context,
        phoneNumber: event.phoneNumber,
      );
      if (value) {
        final adminData = await CommonDbFunctions.getAdminByNumber(
            phoneNumber: event.phoneNumber);
        add(GetCurrentAdminNumberEvent(number: event.phoneNumber));
        if (adminData != null) {
          add(GetCurrentAdminData(phoneNumber: event.phoneNumber));
        } else {
          commonSnackBarWidget(
            context: event.context,
            contentText: "No admin found",
          );
        }
      } else {
        commonSnackBarWidget(
          context: event.context,
          contentText: "Invalid credential or error occured",
        );
      }
      // } else {
      //   commonSnackBarWidget(
      //     context: event.context,
      //     contentText: "Enter correct phone number",
      //   );
      // }
    } catch (e) {
      emit(AdminErrorState(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> addAdminEvent(
      AddAdminEvent event, Emitter<AdminState> emit) async {
    try {
      final value = await adminRepository.addAdmin(
        adminModel: event.adminModel,
        profileImageFile: event.imageFile,
      );
      if (value) {
        emit(AdminState(
            message: "Created successfully", country: state.country));
      } else {
        emit(
          AdminErrorState(
            errorMessage: "Something went wrong",
          ),
        );
      }
    } catch (e) {
      emit(AdminErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> countrySelectedEvent(
      CountrySelectedEvent event, Emitter<AdminState> emit) {
    emit(AdminState(country: event.selectedCountry));
  }

  FutureOr<void> enableUserEvent(
      EnableUserEvent event, Emitter<AdminState> emit) async {
    try {
      final value = await adminRepository.enableUser(userId: event.userId);
      if (value) {
        emit(AdminState(message: 'Enabled successfully'));
      } else {
        emit(AdminErrorState(errorMessage: "Unable to enable user"));
      }
    } catch (e) {
      emit(AdminErrorState(errorMessage: "Something went wrong"));
    }
  }

  Future<FutureOr<void>> disableUserEvent(
      DisableUserEvent event, Emitter<AdminState> emit) async {
    try {
      final value = await adminRepository.disableUser(userId: event.userId);
      if (value) {
        emit(AdminState(message: 'Disabled successfully'));
      } else {
        emit(AdminErrorState(errorMessage: "Unable to disable user"));
      }
    } catch (e) {
      emit(AdminErrorState(errorMessage: "Unable to disable user"));
    }
  }

  Future<FutureOr<void>> imagePickEvent(
      ImagePickEvent event, Emitter<AdminState> emit) async {
    try {
      final pickedFile = await pickOneFile();
      if (pickedFile != null) {
        emit(state.copyWith(
          pickedFile: pickedFile,
        ));
      } else {
        emit(AdminErrorState(errorMessage: "Unable to pick image"));
      }
    } catch (e) {
      emit(AdminErrorState(errorMessage: "Unable to pick image"));
    }
  }

  FutureOr<void> getAllAdminsEvent(
      GetAllAdminsEvent event, Emitter<AdminState> emit) {
    try {
      final adminsList = adminRepository.getAllAdmins();
      emit(state.copyWith(adminsList: adminsList));
    } catch (e) {
      emit(AdminErrorState(errorMessage: "Something went wrong"));
    }
  }

  FutureOr<void> getCurrentAdminData(
      GetCurrentAdminData event, Emitter<AdminState> emit) async {
    try {
      final adminData = await CommonDbFunctions.getAdminByNumber(
          phoneNumber: event.phoneNumber);
      emit(state.copyWith(currentAdminData: adminData));
    } catch (e) {
      emit(AdminErrorState(errorMessage: "No admin"));
    }
  }

  Future<FutureOr<void>> checkIfAdminSignedInEvent(
      CheckIfAdminSignedInEvent event, Emitter<AdminState> emit) async {
    final isSignedIn = await CommonDbFunctions.getUserAthStatus();
    emit(state.copyWith(isAdminSignedIn: isSignedIn));
  }

  FutureOr<void> getCurrentAdminNumberEvent(
      GetCurrentAdminNumberEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(adminNumber: event.number));
  }

  FutureOr<void> updateAdminEvent(
      UpdateAdminEvent event, Emitter<AdminState> emit) async {
    try {
      final value = await adminRepository.editProfileData(
          updatedModel: event.updatedAdminModel);
      if (value) {
        add(GetAllAdminsEvent());
      } else {
        emit(AdminErrorState(errorMessage: "Unable to edit profile"));
      }
    } catch (e) {
      emit(AdminErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> deleteAdminEvent(
      DeleteAdminEvent event, Emitter<AdminState> emit) async {
    try {
      final value = await adminRepository.removeAdmin(adminId: event.adminId);
      if (value) {
        add(GetAllAdminsEvent());
      } else {
        emit(AdminErrorState(errorMessage: "Unable to delete admin"));
      }
    } catch (e) {
      emit(AdminErrorState(errorMessage: e.toString()));
    }
  }
}

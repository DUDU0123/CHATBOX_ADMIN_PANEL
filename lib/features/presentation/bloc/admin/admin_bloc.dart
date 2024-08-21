import 'dart:async';
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
      RegExp phoneRegExp =
          RegExp(r'^\+?(\d{1,3})?[-. ]?(\(?\d{3}\)?)[-. ]?\d{3}[-. ]?\d{4}$');
      if (phoneRegExp.hasMatch(event.phoneNumber)) {
        final value = await adminRepository.signInWithPhoneNumber(
          context: event.context,
          phoneNumber: event.phoneNumber,
        );
        if (value) {
          final adminData = await CommonDbFunctions.getAdminByNumber(
              phoneNumber: event.phoneNumber);
          // add(GetCurrentAdminNumberEvent(number: event.phoneNumber));
          if (adminData != null) {
            await CommonDbFunctions.saveAdminData(adminData);
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
      } else {
        commonSnackBarWidget(
          context: event.context,
          contentText: "Enter correct phone number",
        );
      }
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
        emit(state.copyWith(
          message: "Created successfully",
          country: state.country,
          currentAdminData: state.currentAdminData,
        ));
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



  Future<FutureOr<void>> imagePickEvent(
      ImagePickEvent event, Emitter<AdminState> emit) async {
    try {
      final pickedFile = await pickOneFile();
      if (pickedFile != null) {
        emit(state.copyWith(
            pickedFile: pickedFile, currentAdminData: state.currentAdminData));
      } else {
        emit(AdminErrorState(errorMessage: "Unable to pick image"));
      }
    } catch (e) {
      emit(AdminErrorState(errorMessage: "Unable to pick image"));
    }
  }

  Future<FutureOr<void>> getAllAdminsEvent(
      GetAllAdminsEvent event, Emitter<AdminState> emit) async {
    try {
      final adminsList = adminRepository.getAllAdmins();
      emit(state.copyWith(
        adminsList: adminsList,
        currentAdminData: await CommonDbFunctions.getSavedAdminData(),
        adminNumber: state.adminNumber,
        isAdminSignedIn: state.isAdminSignedIn,
        pickedFile: state.pickedFile,
        country: state.country,
      ));
    } catch (e) {
      emit(AdminErrorState(errorMessage: "Something went wrong"));
    }
  }

  FutureOr<void> getCurrentAdminData(
      GetCurrentAdminData event, Emitter<AdminState> emit) async {
    try {
      emit(state.copyWith(
        currentAdminData: await CommonDbFunctions.getSavedAdminData(),
        adminNumber: state.adminNumber,
      ));
    } catch (e) {
      emit(AdminErrorState(errorMessage: "No admin"));
    }
  }

  Future<FutureOr<void>> checkIfAdminSignedInEvent(
      CheckIfAdminSignedInEvent event, Emitter<AdminState> emit) async {
    final isSignedIn = await CommonDbFunctions.getUserAthStatus();
    emit(state.copyWith(isAdminSignedIn: isSignedIn));
  }

  Future<FutureOr<void>> getCurrentAdminNumberEvent(
      GetCurrentAdminNumberEvent event, Emitter<AdminState> emit) async {
    emit(state.copyWith(
      adminNumber: event.number,
      currentAdminData: await CommonDbFunctions.getSavedAdminData(),
    ));
  }

  FutureOr<void> updateAdminEvent(
      UpdateAdminEvent event, Emitter<AdminState> emit) async {
    try {
      final value = await adminRepository.editProfileData(
          profileImageFile: event.imageFile,
          updatedModel: event.updatedAdminModel);
      if (value) {
        final adminData = await CommonDbFunctions.getAdminById(
            adminId: event.updatedAdminModel.id);
        await CommonDbFunctions.saveAdminData(adminData);
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

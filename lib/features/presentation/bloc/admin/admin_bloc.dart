import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/database_constants.dart';
import 'package:official_chatbox_admin_application/core/utils/common_db_functions.dart';
import 'package:official_chatbox_admin_application/core/utils/common_snackbar_widget.dart';
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
          emit(AdminLoginSuccessState());
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
        log('Enabled successfully');
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
        log('Disabled successfully');
        emit(AdminState(message: 'Disabled successfully'));

      } else {
        emit(AdminErrorState(errorMessage: "Unable to disable user"));
      }
    } catch (e) {
      emit(AdminErrorState(errorMessage: "Unable to disable user"));
    }
  }
}

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';

abstract class AdminRepository{

  Future<bool> addAdmin({
    required AdminModel adminModel,
    Uint8List? profileImageFile,
  });
  Stream<List<AdminModel>>? getAllAdmins();
  Future<bool> signInWithPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
  });
  Future<bool> disableUser({
    required String userId,
  });
  Future<bool> enableUser({
    required String userId,
  });
  Future<bool> editProfileData({
    required AdminModel updatedModel,
    Uint8List? profileImageFile,
  });
  Future<bool> removeAdmin({
    required String adminId,
  });
}
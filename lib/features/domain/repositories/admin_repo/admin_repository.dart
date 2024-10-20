import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';

abstract class AdminRepository {
  Future<bool> addAdmin({
    required AdminModel adminModel,
    Uint8List? profileImageFile,
  });
  Stream<List<AdminModel>>? getAllAdmins();
  Future<bool> adminSignInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  });
  Future<bool> editProfileData({
    required AdminModel updatedModel,
    Uint8List? profileImageFile,
  });
  Future<bool> removeAdmin({
    required String adminId,
  });
}

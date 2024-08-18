import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/features/data/data_sources/admin_data/admin_data.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';
import 'package:official_chatbox_admin_application/features/domain/repositories/admin_repo/admin_repository.dart';

class AdminRepoImpl extends AdminRepository {
  final AdminData adminData;
  AdminRepoImpl({
    required this.adminData,
  });
  @override
  Future<bool> addAdmin({required AdminModel adminModel, Uint8List? profileImageFile,}) {
    return adminData.addAdmin(adminModel: adminModel, profileImageFile: profileImageFile,);
  }

  @override
  Future<bool> signInWithPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
  }) {
    return adminData.signInWithPhoneNumber(
      context: context,
      phoneNumber: phoneNumber,
    );
  }
  
  @override
  Future<bool> disableUser({required String userId}) {
    return adminData.disableUser(userId: userId);
  }
  
  @override
  Future<bool> enableUser({required String userId}) {
    return adminData.enableUser(userId: userId);
  }
}

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
  Stream<List<AdminModel>>? getAllAdmins() {
    return adminData.getAllAdminsFromDB();
  }
  
  @override
  Future<bool> editProfileData({required AdminModel updatedModel, Uint8List? profileImageFile}) {
    return adminData.editProfileData(updatedModel: updatedModel, profileImageFile: profileImageFile,);
  }
  
  @override
  Future<bool> removeAdmin({required String adminId}) {
    return adminData.removeAdmin(adminId: adminId);
  }
  
  @override
  Future<bool> adminSignInWithEmailAndPassword({required BuildContext context, required String email, required String password}) {
    return adminData.signInWithPhoneNumber(context: context,email: email, password: password);
  }
  
 
}

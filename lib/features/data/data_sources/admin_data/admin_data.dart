import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/database_constants.dart';
import 'package:official_chatbox_admin_application/core/utils/common_db_functions.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';

class AdminData {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth fireBaseAuth;

  AdminData({
    required this.firebaseFirestore,
    required this.fireBaseAuth,
  });

  Future<bool> addAdmin({
    required AdminModel adminModel,
    Uint8List? profileImageFile,
  }) async {
    try {
      DocumentReference<Map<String, dynamic>> adminDoc = await firebaseFirestore
          .collection(adminsCollection)
          .add(adminModel.toJson());
      String? profileImageUrl;

      final adminDocId = adminDoc.id;
      if (profileImageFile != null) {
        profileImageUrl = await CommonDbFunctions.saveUserFileToDataBaseStorage(
          ref: '$adminsProfilePhotoFolder/$adminDocId',
          file: profileImageFile,
        );
      }
      final updatedAdminModel = adminModel.copyWith(
        id: adminDocId,
        profilePhoto: profileImageUrl,
      );
      await firebaseFirestore
          .collection(adminsCollection)
          .doc(adminDocId)
          .update(
            updatedAdminModel.toJson(),
          );

      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Stream<List<AdminModel>>? getAllAdminsFromDB() {
    try {
      return firebaseFirestore
          .collection(adminsCollection)
          .snapshots()
          .map((adminSnapshot) {
        return adminSnapshot.docs
            .map((adminDoc) => AdminModel.fromJson(map: adminDoc.data()))
            .toList();
      });
    } on FirebaseException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }
  Future<bool> signInWithPhoneNumber({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      QuerySnapshot adminQuerySnapshot = await firebaseFirestore
          .collection(adminsCollection)
          .where(adminEmail, isEqualTo: email)
          .get();

      if (adminQuerySnapshot.docs.isEmpty) {
        return false;
      }
      var adminDoc = adminQuerySnapshot.docs.first;
      String dbPassword = adminDoc[adminPasswordDB];
      if (dbPassword == password) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      return false;
    } catch (e) {
      // Handle any other errors
      return false;
    }
  }

  Future<bool> editProfileData({
    required AdminModel updatedModel,
    Uint8List? profileImageFile,
  }) async {
    try {
      String? profileImageUrl;
      if (profileImageFile != null) {
        profileImageUrl = await CommonDbFunctions.saveUserFileToDataBaseStorage(
          ref: '$adminsProfilePhotoFolder/${updatedModel.id}',
          file: profileImageFile,
        );
      }
      final updatedAdminModel = updatedModel.copyWith(
        profilePhoto: profileImageUrl != null && profileImageUrl.isNotEmpty
            ? profileImageUrl
            : updatedModel.profilePhoto,
      );
      await firebaseFirestore
          .collection(adminsCollection)
          .doc(updatedModel.id)
          .update(updatedAdminModel.toJson());

      await CommonDbFunctions.setUserAuthStatus(isSignedIn: true);
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeAdmin({
    required String adminId,
  }) async {
    try {
      await firebaseFirestore
          .collection(adminsCollection)
          .doc(adminId)
          .delete();
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }
}

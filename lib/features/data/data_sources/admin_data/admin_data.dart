import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/database_constants.dart';
import 'package:official_chatbox_admin_application/core/utils/common_db_functions.dart';

import 'package:official_chatbox_admin_application/core/utils/common_snackbar_widget.dart';
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
      log("Admin add error ${e.message}");
      return false;
    } catch (e) {
      log("Admin add error $e");
      return false;
    }
  }

  // Method to start phone number verification for admins only
  Future<bool> signInWithPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      QuerySnapshot adminQuerySnapshot = await firebaseFirestore
          .collection(adminsCollection)
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (adminQuerySnapshot.docs.isEmpty) {
        return false;
      }

      await fireBaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await fireBaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          commonSnackBarWidget(
            context: context,
            contentText: 'Verification failed: ${e.message}',
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          showOtpDialog(context: context, verificationId: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return true;
    } on FirebaseAuthException catch (e) {
      log('Error during sign-in: ${e.message}');
      return false;
    } catch (e) {
      log('Error during sign-in: ${e.toString()}');
      return false;
    }
    return false;
  }

  // Method to manually sign in using OTP after user input
  Future<bool> verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String otp,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await fireBaseAuth.signInWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      log("Otp verify error: ${e.message}");
      return false;
    } catch (e) {
      log('Error otp verify: ${e.toString()}');
      return false;
    }
  }

  void showOtpDialog({
    required BuildContext context,
    required String verificationId,
  }) {
    TextEditingController otpController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter OTP'),
          content: TextField(
            controller: otpController,
            decoration: const InputDecoration(labelText: 'OTP'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await verifyOtp(
                  context: context,
                  verificationId: verificationId,
                  otp: otpController.text,
                );
              },
              child: const Text('Verify'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> disableUser({
    required String userId,
  }) async {
    try {
      await firebaseFirestore.collection(usersCollection).doc(userId).update({
        isUserDisabled: true,
      });
      return true;
    } on FirebaseException catch (e) {
      log("disable user firebase exception ${e.message}");
      return false;
    } catch (e) {
      log("disable user firebase exception $e");
      return false;
    }
  }

  Future<bool> enableUser({
    required String userId,
  }) async {
    try {
      await firebaseFirestore.collection(usersCollection).doc(userId).update({
        isUserDisabled: false,
      });
      return true;
    } on FirebaseException catch (e) {
      log("disable user firebase exception ${e.message}");
      return false;
    } catch (e) {
      log("disable user firebase exception $e");
      return false;
    }
  }
}

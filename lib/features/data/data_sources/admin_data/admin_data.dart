import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:official_chatbox_admin_application/core/constants/database_constants.dart';
import 'package:official_chatbox_admin_application/core/utils/common_db_functions.dart';

import 'package:official_chatbox_admin_application/core/utils/common_snackbar_widget.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';
import 'package:official_chatbox_admin_application/features/presentation/pages/main_navigate_page/main_navigation_page.dart';

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
      log("get all admins error firebase: ${e.message}");
      return null;
    } catch (e) {
      log('get all admins error: ${e.toString()}');
      return null;
    }
  }

  // Method to start phone number verification for admins only
  Future<bool> signInWithPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      log("Number: $phoneNumber");
      QuerySnapshot adminQuerySnapshot = await firebaseFirestore
          .collection(adminsCollection)
          .where(adminPhoneNumber, isEqualTo: phoneNumber)
          .get();
      //  firebaseFirestore
      //     .collection(adminsCollection).snapshots().map((val)=>val.docs.map((val)=>log(val.toString())));

      log("Snap: ${adminQuerySnapshot.docs}");

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
                final value = await verifyOtp(
                  context: context,
                  verificationId: verificationId,
                  otp: otpController.text,
                );

                if (value) {
                  await CommonDbFunctions.setUserAuthStatus(isSignedIn: true);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainNavigationPage(),
                    ),
                    (route) => false,
                  );
                } else {
                  return;
                }
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
      log("disable user exception $e");
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
      log("enable user firebase exception ${e.message}");
      return false;
    } catch (e) {
      log("enable user  exception $e");
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
        profilePhoto: profileImageUrl,
      );
      await firebaseFirestore
          .collection(adminsCollection)
          .doc(adminId)
          .update(updatedAdminModel.toJson());
      return true;
    } on FirebaseException catch (e) {
      log("delete admin firebase exception ${e.message}");
      return false;
    } catch (e) {
      log("delete admin  exception $e");
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
      log("delete admin firebase exception ${e.message}");
      return false;
    } catch (e) {
      log("delete admin exception $e");
      return false;
    }
  }
}

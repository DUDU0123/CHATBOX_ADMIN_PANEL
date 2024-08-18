import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:official_chatbox_admin_application/core/constants/database_constants.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';

class UsersData {
  final FirebaseFirestore firebaseFirestore;
  UsersData({
    required this.firebaseFirestore,
  });

  Stream<List<UserModel>>? getAllUsersInDB() {
    try {
      return firebaseFirestore
          .collection(usersCollection)
          .snapshots()
          .map((userSnapshot) {
        log("Snaps docs: ${userSnapshot.docs}");
        return userSnapshot.docs
            .map(
              (doc) => UserModel.fromJson(
                map: doc.data(),
              ),
            )
            .toList();
      });
    } on FirebaseException catch (e) {
      log("Get all users firebase exception ${e.message}");
      return null;
    } catch (e) {
      log("Get all users firebase exception $e");
      return null;
    }
  }

  Stream<List<UserModel>>? getAllDisabledUsersFromDB() {
    try {
      return firebaseFirestore
          .collection(usersCollection)
          .where(isUserDisabled, isEqualTo: true)
          .snapshots()
          .map((userSnapshot) {
        log("Snaps docs: ${userSnapshot.docs}");
        return userSnapshot.docs
            .map(
              (doc) => UserModel.fromJson(
                map: doc.data(),
              ),
            )
            .toList();
      });
    } on FirebaseException catch (e) {
      log("Get all disabled users firebase exception ${e.message}");
      return null;
    } catch (e) {
      log("Get all disabled users firebase exception $e");
      return null;
    }
  }

  Stream<List<UserModel>>? getAllReportedAccountsFromDB() {
    try {
      return firebaseFirestore
          .collection(reportedUsersCollection)
          .snapshots()
          .map((userSnapshot) {
        log("Snaps docs: ${userSnapshot.docs}");
        return userSnapshot.docs
            .map(
              (doc) => UserModel.fromJson(
                map: doc.data(),
              ),
            )
            .toList();
      });
    } on FirebaseException catch (e) {
      log("Get all disabled users firebase exception ${e.message}");
      return null;
    } catch (e) {
      log("Get all disabled users firebase exception $e");
      return null;
    }
  }
}

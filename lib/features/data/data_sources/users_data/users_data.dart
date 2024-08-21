import 'package:cloud_firestore/cloud_firestore.dart';
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
        return userSnapshot.docs
            .map(
              (doc) => UserModel.fromJson(
                map: doc.data(),
              ),
            )
            .toList();
      });
    } on FirebaseException catch (e) {
      return null;
    } catch (e) {
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
        return userSnapshot.docs
            .map(
              (doc) => UserModel.fromJson(
                map: doc.data(),
              ),
            )
            .toList();
      });
    } on FirebaseException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  Stream<List<UserModel>>? getAllReportedAccountsFromDB() {
    try {
      return firebaseFirestore
          .collection(reportedUsersCollection)
          .snapshots()
          .map((userSnapshot) {
        return userSnapshot.docs
            .map(
              (doc) => UserModel.fromJson(
                map: doc.data(),
              ),
            )
            .toList();
      });
    } on FirebaseException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
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
      return false;
    } catch (e) {
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
      return false;
    } catch (e) {
      return false;
    }
  }
}

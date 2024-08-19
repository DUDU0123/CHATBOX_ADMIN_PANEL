import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:official_chatbox_admin_application/config/all_bloc_provider.dart';
import 'package:official_chatbox_admin_application/core/constants/database_constants.dart';
import 'package:official_chatbox_admin_application/features/data/models/admin_model/admin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonDbFunctions {
  static const userAuthStatusKey = "is_admin_signedIn";
  
  static Future<bool> getUserAthStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(userAuthStatusKey) ?? false;
  }

  
 static Future<void> setUserAuthStatus({required bool isSignedIn}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(userAuthStatusKey, isSignedIn);
  }

  static Future<String> saveUserFileToDataBaseStorage({
    required String ref,
    required Uint8List file,
  }) async {
    try {
      UploadTask uploadTask = fireStorage.ref().child(ref).putData(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      log(
        'Firebase Auth exception: $e',
      );
      throw Exception("Error while saving file to storage: $e");
    } catch (e, stackTrace) {
      log('Error while saving file to storage: $e', stackTrace: stackTrace);
      throw Exception("Error while saving file to storage: $e");
    }
  }

  static Future<AdminModel?> getAdminById({
    required String? adminId,
  }) async {
    try {
      final adminDoc =
          await fireStore.collection(adminsCollection).doc(adminId).get();
      return AdminModel.fromJson(map: adminDoc.data()!);
    } on FirebaseException catch (e) {
      log('Firebase  exception admin get: $e');
      return null;
    } catch (e) {
      log('Exception admin get: $e');
      return null;
    }
  }

 static Future<AdminModel?> getAdminByNumber({required String phoneNumber}) async {
  try {
    QuerySnapshot querySnapshot = await fireStore
        .collection(adminsCollection)
        .where(adminPhoneNumber, isEqualTo: phoneNumber)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var adminData = querySnapshot.docs.first.data() as Map<String, dynamic>; // Cast to Map<String, dynamic>
      return AdminModel.fromJson(map: adminData); // Return the first matching admin
    } else {
      log("No admin found with this phone number.");
      return null;
    }
  } on FirebaseException catch (e) {
    log("get admin by phone number error firebase: ${e.message}");
    return null;
  } catch (e) {
    log('get admin by phone number error: ${e.toString()}');
    return null;
  }
}

}


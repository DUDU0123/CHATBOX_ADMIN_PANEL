import 'dart:convert';
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

  static Future<void> saveAdminData(AdminModel? admin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentAdminData', jsonEncode(admin?.toJson()));
  }

  static Future<AdminModel?> getSavedAdminData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? adminDataString = prefs.getString('currentAdminData');
    if (adminDataString != null) {
      return AdminModel.fromJson(map: jsonDecode(adminDataString));
    }
    return null;
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

      throw Exception("Error while saving file to storage: $e");
    } catch (e) {
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
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<AdminModel?> getAdminByNumber(
      {required String phoneNumber}) async {
    try {
      QuerySnapshot querySnapshot = await fireStore
          .collection(adminsCollection)
          .where(adminPhoneNumber, isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var adminData = querySnapshot.docs.first.data()
            as Map<String, dynamic>; // Cast to Map<String, dynamic>
        return AdminModel.fromJson(
            map: adminData); // Return the first matching admin
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }
}

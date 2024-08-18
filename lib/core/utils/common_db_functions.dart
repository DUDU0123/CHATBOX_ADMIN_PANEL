import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:official_chatbox_admin_application/config/all_bloc_provider.dart';

class CommonDbFunctions{
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
}
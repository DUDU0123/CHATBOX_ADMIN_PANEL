import 'dart:developer';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

Future<Uint8List?> pickOneFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    Uint8List? fileBytes;
    if (result != null) {
      // file = File(result.files.single.bytes!);
       fileBytes = result.files.single.bytes!;
      return fileBytes;
    } else {
      return null;
    }
  } catch (e) {
    log("File picker exception");
    throw Exception(e);
  }
}

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

Future<Uint8List?> pickOneFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    Uint8List? fileBytes;
    if (result != null) {
       fileBytes = result.files.single.bytes!;
      return fileBytes;
    } else {
      return null;
    }
  } catch (e) {
    throw Exception(e);
  }
}

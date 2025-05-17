import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fruits_hub_dashboard/core/services/stoarage_service.dart';
import 'package:path/path.dart' as b;

class FireStorage implements StoarageService {
  final stoarageReference = FirebaseStorage.instance.ref();
  @override
  Future<String> uploadFile(File file, String path) async {
    String fileName = b.basename(file.path);
    String extensionName = b.extension(file.path);
    var fileReferance = stoarageReference.child('$path/$fileName.$extensionName');
    await fileReferance.putFile(file);
    return fileReferance.getDownloadURL();
  }
}

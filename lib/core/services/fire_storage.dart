import 'package:firebase_storage/firebase_storage.dart';
import 'package:fruits_hub_dashboard/core/services/stoarage_service.dart';

class FireStorage implements StoarageService {
  final stoarageReference = FirebaseStorage.instance;
  @override
  Future<String> uploadFile(String file) {
    throw UnimplementedError();
  }
}

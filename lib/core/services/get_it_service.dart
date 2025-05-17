import 'package:fruits_hub_dashboard/core/services/fire_storage.dart';
import 'package:fruits_hub_dashboard/core/services/stoarage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

// Singleton => It Creates An Object immediately when we call setup method
// Lazy Singelton =>  when you need to create an object you need to call it

void setupGetIt() {
  getIt.registerLazySingleton<StoarageService>(() => FireStorage());
}

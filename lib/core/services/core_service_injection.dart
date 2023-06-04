import 'package:get_it/get_it.dart';

import 'firestore_service.dart';
import 'local_service.dart';

class CoreServiceInjection {
  static void setup() {
    GetIt getIt = GetIt.instance;

    getIt.registerLazySingleton<FirestoreService>(
      () => FirestoreService(getIt.get()),
    );
    getIt.registerLazySingleton<LocalService>(() => LocalService());
  }
}

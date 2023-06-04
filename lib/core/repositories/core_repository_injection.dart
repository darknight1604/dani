import 'package:get_it/get_it.dart';

import 'local/local_repository.dart';
import 'remote/firestore_repository.dart';

class CoreRepositoryInjection {
  static void setup() {
    GetIt getIt = GetIt.instance;

    getIt.registerLazySingleton<LocalRepository>(() => LocalRepository());
    getIt.registerLazySingleton<FirestoreRepository>(
        () => FirestoreRepository());
  }
}

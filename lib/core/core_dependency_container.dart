import 'package:alpha/core/services/firestore_service.dart';
import 'package:alpha/core/services/local_service.dart';
import 'package:get_it/get_it.dart';

import 'repositories/local/local_repository.dart';
import 'repositories/remote/firestore_repository.dart';

class CoreDependencyContainer {
  static void setup(GetIt instance) {
    /// Repositories
    instance.registerLazySingleton<LocalRepository>(() => LocalRepository());
    instance.registerLazySingleton<FirestoreRepository>(
      () => FirestoreRepository(),
    );

    /// Services
    instance.registerLazySingleton<FirestoreService>(
      () => FirestoreService(instance.get()),
    );
    instance.registerLazySingleton<LocalService>(() => LocalService());
  }
}

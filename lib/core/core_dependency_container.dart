import 'package:dani/core/services/firestore_service.dart';
import 'package:dani/core/services/local_service.dart';
import 'package:get_it/get_it.dart';

import 'applications/loading/loading_bloc.dart';
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
      () => FirestoreService(
        instance.get(),
        instance.get(),
      ),
    );
    instance.registerLazySingleton<LocalService>(
        () => LocalService(instance.get()));

    /// Applications
    instance.registerFactory<LoadingBloc>(() => LoadingBloc());
  }
}

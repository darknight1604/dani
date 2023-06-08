import 'package:dani/dependency_container.dart';
import 'package:get_it/get_it.dart';

import 'applications/spending_listing/spending_listing_bloc.dart';
import 'services/spending_service.dart';

class SpendingDiContainer extends DiContainer {
  @override
  void setup(GetIt instance) {
    instance.registerLazySingleton<SpendingService>(
      () => SpendingService(instance.get()),
    );
    instance.registerFactory<SpendingListingBloc>(
      () => SpendingListingBloc(instance.get()),
    );
  }
}

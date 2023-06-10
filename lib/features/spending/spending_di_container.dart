import 'package:dani/dependency_container.dart';
import 'package:get_it/get_it.dart';

import 'applications/spending_listing/spending_listing_bloc.dart';
import 'bussinesses/spending_business.dart';
import 'services/spending_service.dart';

class SpendingDiContainer extends DiContainer {
  @override
  void setup(GetIt instance) {
    /// Services
    instance.registerLazySingleton<SpendingService>(
      () => SpendingService(instance.get()),
    );

    /// Businesses
    /// 
    instance.registerLazySingleton<SpendingBusiness>(
      () => SpendingBusiness(instance.get()),
    );

    /// Blocs
    instance.registerFactory<SpendingListingBloc>(
      () => SpendingListingBloc(instance.get()),
    );
  }
}

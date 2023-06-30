import 'package:dani/dependency_container.dart';
import 'package:get_it/get_it.dart';

import '../../core/app_route.dart';
import 'maintenance_route.dart';

class MaintenanceDiContainer extends DiContainer {
  @override
  void setup(GetIt instance) {
    /// Route
    instance.registerLazySingleton<MaintenanceRoute>(
      () => MaintenanceRoute(),
    );
    instance
        .get<FeatureRouteFactory>()
        .register(instance.get<MaintenanceRoute>());
  }
}

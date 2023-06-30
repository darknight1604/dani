import 'package:dani/core/app_route.dart';
import 'package:dani/core/constants.dart';
import 'package:dani/features/maintenance/presentations/maintenance_screen.dart';
import 'package:flutter/src/material/page.dart';

class MaintenanceRoute extends FeatureRoute {
  @override
  MaterialPageRoute generateRoute(Object? arguments) {
    return MaterialPageRoute(builder: (context) => const MaintenanceScreen());
  }

  @override
  String get routeName => ScreenPath.maintenanceScreen;
}

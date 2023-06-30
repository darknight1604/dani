import 'package:dani/core/app_route.dart';
import 'package:dani/core/constants.dart';
import 'package:flutter/src/material/page.dart';

import 'presentations/home_screen.dart';

class HomeRoute extends FeatureRoute {
  @override
  MaterialPageRoute generateRoute(Object? arguments) {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }

  @override
  String get routeName => ScreenPath.homeScreen;
}

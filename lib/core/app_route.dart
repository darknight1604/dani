import 'package:flutter/material.dart';

import '../features/login/presentations/login_screen.dart';

class AppRoute {
  AppRoute._();
  static const String loginScreen = "/loginScreen";

  static String initialRoute() {
    return loginScreen;
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    String? routeName = settings.name;
    if (routeName == null || routeName.isEmpty) {}
    switch (routeName) {
      case loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      default:
    }
    return null;
  }
}

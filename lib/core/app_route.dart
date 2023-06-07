import 'package:alpha/features/home_screen/presentations/home_screen.dart';
import 'package:flutter/material.dart';

import '../features/login/presentations/login_screen.dart';
import '../features/spending/presentations/spending_screen.dart';
import 'app_config.dart';

class AppRoute {
  AppRoute._();
  static const String loginScreen = "/loginScreen";

  static const String homeScreen = "/homeScreen";

  static const String spendingScreen = "/spendingScreen";

  static String initialRoute(AppConfig appConfig) {
    if (appConfig.isLogged) {
      return homeScreen;
    }
    return loginScreen;
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    String? routeName = settings.name;
    if (routeName == null || routeName.isEmpty) {}
    switch (routeName) {
      case loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case spendingScreen:
        return MaterialPageRoute(builder: (context) => const SpendingScreen());
      default:
        return null;
    }
  }

  static pushReplacement(BuildContext context, final String name,
      {final Object? arguments}) {
    Navigator.of(context).popUntil((route) => route.isFirst);

    final Route<dynamic>? newRoute = onGenerateRoute(
      RouteSettings(
        name: name,
        arguments: arguments,
      ),
    );
    if (newRoute != null) {
      Navigator.pushReplacement(
        context,
        newRoute,
      );
    }
  }
}

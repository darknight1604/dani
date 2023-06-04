import 'package:alpha/core/app_config.dart';
import 'package:alpha/core/app_route.dart';
import 'package:alpha/core/utils/text_theme_util.dart';
import 'package:alpha/dependency_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  DependencyContainer.setup();
  await AppConfig.instance.initial();
  await Firebase.initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('vi'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextThemeUtil.instance.initial(context);
    return MaterialApp(
      title: 'Flutter Demo',
      supportedLocales: [
        Locale('en'),
        Locale('vi'),
      ],
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      initialRoute: AppRoute.initialRoute(AppConfig.instance),
      onGenerateRoute: AppRoute.onGenerateRoute,
      color: Colors.amberAccent,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

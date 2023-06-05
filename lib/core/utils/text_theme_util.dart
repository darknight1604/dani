import 'package:alpha/core/constants.dart';
import 'package:flutter/material.dart';

class TextThemeUtil {
  TextThemeUtil._internal();

  static TextThemeUtil? _instance;

  static TextThemeUtil get instance => _instance ??= TextThemeUtil._internal();

  void initial(BuildContext context) {
    titleLarge = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(color: Constants.defaultTextColor);
    titleMedium = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(color: Constants.defaultTextColor);

    bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(color: Constants.defaultTextColor);
    bodyMedium = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: Constants.defaultTextColor);
    bodySmall = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: Constants.defaultTextColor);
  }

  TextStyle? titleLarge;
  TextStyle? titleMedium;

  TextStyle? bodyLarge;
  TextStyle? bodyMedium;
  TextStyle? bodySmall;
}

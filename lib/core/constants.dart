import 'package:flutter/material.dart';

import 'utils/text_theme_util.dart';

class Constants {
  static const double iconSizeLarge = 100;

  static const String token = 'token';

  static const String user = 'user';

  static const double padding = 16.0;

  static const double spacingBetweenWidget = 12.0;

  static const String currencySymbol = 'VNĐ';

  static TextSpan redStar = TextSpan(
    text: '*',
    style: TextThemeUtil.instance.bodyMedium?.copyWith(color: Colors.red),
  );

  static Color disableColor = Colors.grey.shade400;

  static const Color defaultTextColor = Colors.black;

  static const double radius = 8.0;

  static Color borderColor = Colors.grey.shade400;
}

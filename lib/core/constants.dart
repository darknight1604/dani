import 'package:flutter/material.dart';

import 'utils/text_theme_util.dart';

class Constants {
  static const double iconSizeLarge = 100;

  static const String token = 'token';

  static const double padding = 16.0;

  static const double spacingBetweenWidget = 12.0;

  static const String currencySymbol = 'VNĐ';

  static TextSpan redStar = TextSpan(
    text: '*',
    style: TextThemeUtil.instance.bodyMedium?.copyWith(color: Colors.red),
  );

  static const Color disableColor = Colors.grey;
}

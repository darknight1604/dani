import 'package:flutter/material.dart';

import '../constants.dart';
import '../utils/text_theme_util.dart';
import 'package:alpha/core/utils/extensions/text_style_extension.dart';

abstract class MyBtn extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  MyBtn({
    required this.title,
    required this.onTap,
  });
}

class MyFilledBtn extends MyBtn {
  MyFilledBtn({
    required super.title,
    required super.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MyFilledWithChildBtn(
      onTap: onTap,
      child: Text(
        title,
        style: TextThemeUtil.instance.bodyMedium?.semiBold.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class MyFilledWithChildBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  MyFilledWithChildBtn({
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.primary,
      fixedSize: Size(120, 50),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Constants.radius)),
      ),
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            );
          return BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ); // Defer to the widget's default.
        },
      ),
    );

    return OutlinedButton(
      style: outlineButtonStyle,
      onPressed: onTap,
      child: child,
    );
  }
}

class MyOutlineBtn extends MyBtn {
  MyOutlineBtn({
    required super.title,
    required super.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      foregroundColor: Constants.defaultTextColor,
      fixedSize: Size(120, 50),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Constants.radius)),
      ),
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            );
          return BorderSide(
            color: Constants.borderColor,
          ); // Defer to the widget's default.
        },
      ),
    );

    return OutlinedButton(
      style: outlineButtonStyle,
      onPressed: onTap,
      child: Text(
        title,
        style: TextThemeUtil.instance.bodyMedium?.semiBold.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

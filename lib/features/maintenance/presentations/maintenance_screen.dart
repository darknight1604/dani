import 'dart:io';

import 'package:dani/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/utils/text_theme_util.dart';
import '../../../core/widgets/my_btn.dart';
import '../../../gen/locale_keys.g.dart';
import 'package:dani/core/utils/extensions/text_style_extension.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Assets.images.maintenance.image(height: 200),
                  Text(
                    tr(LocaleKeys.common_maintenanceDescription1),
                    style: TextThemeUtil.instance.titleLarge,
                  ),
                  SizedBox(
                    height: Constants.padding,
                  ),
                  Text(
                    tr(LocaleKeys.common_maintenanceDescription2),
                    style: TextThemeUtil.instance.titleMedium
                        ?.copyWith(color: Constants.disableColor),
                  ),
                ],
              ),
            ),
          ),
          MyFilledWithChildBtn(
            onTap: () {
              exit(0);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.white,
                  size: Constants.iconSize,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  tr(LocaleKeys.common_exit),
                  style: TextThemeUtil.instance.bodyMedium?.semiBold
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Constants.padding,
          ),
        ],
      ),
    );
  }
}

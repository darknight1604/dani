import 'package:alpha/core/constants.dart';
import 'package:alpha/core/services/firestore_service.dart';
import 'package:alpha/core/utils/text_theme_util.dart';
import 'package:alpha/gen/locale_keys.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../core/widgets/input_text_field.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({super.key});

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
  @override
  void initState() {
    super.initState();
    FirestoreService firestoreService = GetIt.I.get();
    firestoreService.getListSpendingType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          tr(LocaleKeys.spendingScreen_appBarTitle),
          style:
              TextThemeUtil.instance.titleMedium?.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tr(LocaleKeys.spendingScreen_whatDidYouSpendToday),
              style: TextThemeUtil.instance.bodyMedium,
            ),
            Form(
              child: Column(
                children: [
                  InputTextField(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

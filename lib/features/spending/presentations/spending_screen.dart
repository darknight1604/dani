import 'package:alpha/core/constants.dart';
import 'package:alpha/core/utils/string_util.dart';
import 'package:alpha/core/utils/text_theme_util.dart';
import 'package:alpha/features/spending/models/spending_category.dart';
import 'package:alpha/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../core/widgets/input_text_field.dart';
import '../../../gen/assets.gen.dart';
import '../applications/spending/spending_bloc.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({super.key});

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
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
      body: BlocProvider<SpendingBloc>(
        create: (context) => SpendingBloc()
          ..add(
            FetchSpendingCategoryEvent(),
          ),
        child: _BodyScreen(),
      ),
    );
  }
}

class _BodyScreen extends StatefulWidget {
  @override
  State<_BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<_BodyScreen> {
  final _controller = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.lotties.thinking.lottie(),
          Text(
            tr(LocaleKeys.spendingScreen_whatDidYouSpendToday),
            style: TextThemeUtil.instance.bodyMedium,
          ),
          Form(
            child: Column(
              children: [
                BlocBuilder<SpendingBloc, SpendingState>(
                  builder: (context, state) {
                    if (state is! SpendingLoaded) {
                      return Text(tr(LocaleKeys.common_loading));
                    }
                    List<SpendingCategory> spendingCategories =
                        state.spendingCategories;
                    return DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<SpendingCategory>(
                        hint: Text(
                          tr(LocaleKeys.spendingScreen_whatDidYouSpendToday),
                        ),
                        style: TextThemeUtil.instance.bodyMedium,
                        decoration: InputDecoration(
                          labelText: tr(LocaleKeys.spendingScreen_spendingType),
                          labelStyle:
                              TextThemeUtil.instance.bodyMedium?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value) {},
                        items: spendingCategories
                            .map(
                              (spendingCategory) => DropdownMenuItem(
                                onTap: () {},
                                value: spendingCategory,
                                child: Text(spendingCategory.name ?? ''),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: Constants.spacingBetweenWidget,
                ),
                InputTextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  // labelText: tr(LocaleKeys.spendingScreen_cost),
                  // hintText: tr(LocaleKeys.spendingScreen_cost),
                  labelWidget: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: tr(LocaleKeys.spendingScreen_cost),
                          style: TextThemeUtil.instance.bodyMedium,
                        ),
                        TextSpan(
                          text: ' ',
                        ),
                        Constants.redStar,
                      ],
                    ),
                  ),
                  suffixText: Constants.currencySymbol,
                  validator: (value) {
                    if (StringUtil.isNullOrEmpty(value)) {
                      return tr(LocaleKeys.common_requireField);
                    }
                    return null;
                  },
                  onChanged: (string) {
                    string = '${_formatNumber(string.replaceAll(',', ''))}';
                    _controller.value = TextEditingValue(
                      text: string,
                      selection: TextSelection.collapsed(offset: string.length),
                    );
                  },
                ),
                SizedBox(
                  height: Constants.spacingBetweenWidget,
                ),
                InputTextField(
                  labelText: tr(LocaleKeys.common_note),
                  hintText: tr(LocaleKeys.common_note),
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

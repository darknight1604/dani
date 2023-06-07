import 'package:dani/core/applications/loading/loading_bloc.dart';
import 'package:dani/core/constants.dart';
import 'package:dani/core/utils/extensions/text_style_extension.dart';
import 'package:dani/core/utils/text_theme_util.dart';
import 'package:dani/core/widgets/base_stateful.dart';
import 'package:dani/features/spending/models/spending_category.dart';
import 'package:dani/gen/locale_keys.g.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/string_util.dart';
import '../../../core/widgets/input_text_field.dart';
import '../../../core/widgets/my_btn.dart';
import '../applications/spending/spending_bloc.dart';
import '../models/spending_request.dart';

class SpendingScreen extends BaseStateful {
  const SpendingScreen({super.key});

  @override
  _SpendingScreenState createState() => _SpendingScreenState();
}

class _SpendingScreenState extends BaseStatefulState {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadingBloc.add(LoadingShowEvent());
    });
  }

  @override
  Widget buildChild() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(LocaleKeys.spendingScreen_appBarTitle),
          style:
              TextThemeUtil.instance.titleMedium?.semiBold.copyWith(color: Colors.white),
        ),
      ),
      body: BlocProvider<SpendingBloc>(
        create: (context) => SpendingBloc()
          ..add(
            FetchSpendingCategoryEvent(),
          ),
        child: BlocListener<SpendingBloc, SpendingState>(
          listener: (context, state) {
            if (state is SpendingLoaded) {
              loadingBloc.add(LoadingDismissEvent());
            }
          },
          child: _BodyScreen(),
        ),
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

  final GlobalKey<FormState> _key = GlobalKey();

  late SpendingRequest _spendingRequest;

  @override
  void initState() {
    super.initState();
    _spendingRequest = SpendingRequest(cost: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tr(LocaleKeys.spendingScreen_whatDidYouSpendToday),
            style: TextThemeUtil.instance.bodyMedium?.regular,
          ),
          SizedBox(
            height: 50,
          ),
          Form(
            key: _key,
            child: Column(
              children: [
                InputTextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  // labelText: tr(LocaleKeys.spendingScreen_cost),
                  hintText: tr(LocaleKeys.spendingScreen_cost),
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
                  onSaved: (value) {
                    if (StringUtil.isNullOrEmpty(value)) return;
                    _spendingRequest.cost =
                        int.parse(value!.replaceAll(',', 'replace'));
                  },
                ),
                SizedBox(
                  height: Constants.spacingBetweenWidget,
                ),
                BlocBuilder<SpendingBloc, SpendingState>(
                  builder: (context, state) {
                    if (state is! SpendingLoaded) {
                      return Text(tr(LocaleKeys.common_loading));
                    }
                    List<SpendingCategory> spendingCategories =
                        state.spendingCategories;
                    return DropdownButtonFormField2<SpendingCategory>(
                      style: TextThemeUtil.instance.bodyMedium,
                      decoration: InputDecoration(
                        label: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            tr(LocaleKeys.spendingScreen_spendingType),
                            style: TextThemeUtil.instance.bodyMedium?.regular,
                          ),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Constants.radius),
                        ),
                      ),
                      isExpanded: true,
                      hint: Text(
                        tr(LocaleKeys.spendingScreen_whatDidYouSpendToday),
                        style:
                            TextThemeUtil.instance.bodyMedium?.regular.disable,
                      ),
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.zero,
                        height: 50,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Constants.radius),
                        ),
                      ),
                      items: spendingCategories
                          .map(
                            (spendingCategory) => DropdownMenuItem(
                              onTap: () {},
                              value: spendingCategory,
                              child: Text(spendingCategory.name ?? ''),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {},
                      onSaved: (newValue) {
                        _spendingRequest.categoryId = newValue?.id ?? '';
                      },
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
                  onSaved: (newValue) {
                    _spendingRequest.note = newValue;
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyOutlineBtn(
                  title: tr(LocaleKeys.common_cancel),
                  onTap: () {},
                ),
                MyFilledBtn(
                  title: tr(LocaleKeys.common_confirm),
                  onTap: () {
                    if (_key.currentState?.validate() ?? false) {
                      _key.currentState?.save();
                      BlocProvider.of<SpendingBloc>(context)
                          .add(CreateSpendingEvent(_spendingRequest));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

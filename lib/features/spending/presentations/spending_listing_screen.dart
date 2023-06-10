import 'dart:math';

import 'package:dani/core/constants.dart';
import 'package:dani/core/utils/extensions/date_time_extension.dart';
import 'package:dani/core/utils/extensions/text_style_extension.dart';
import 'package:dani/core/utils/string_util.dart';
import 'package:dani/core/utils/text_theme_util.dart';
import 'package:dani/features/spending/models/spending.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/applications/loading/loading_bloc.dart';
import '../../../core/widgets/base_stateful.dart';
import '../../../core/widgets/empty_widget.dart';
import '../applications/spending_listing/spending_listing_bloc.dart';

part './spending_item.dart';

class SpendingListingScreen extends StatefulWidget {
  const SpendingListingScreen({super.key});

  @override
  State<SpendingListingScreen> createState() => _SpendingListingScreenState();
}

class _SpendingListingScreenState extends State<SpendingListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: _ScreenBody(),
    );
  }
}

class _ScreenBody extends BaseStateful {
  @override
  BaseStatefulState createState() => _ScreenBodyState();
}

class _ScreenBodyState extends BaseStatefulState {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadingBloc.add(LoadingShowEvent());
    });
  }

  @override
  Widget buildChild(BuildContext context) {
    return BlocBuilder<SpendingListingBloc, SpendingListingState>(
      builder: (context, state) {
        if (state is SpendingListingLoaded) {
          BlocProvider.of<LoadingBloc>(context).add(LoadingDismissEvent());

          if (state.listSpending.isEmpty) {
            return EmptyWidget();
          }
          Map<DateTime, List<Spending>> listSpending = state.listSpending;
          return ListView.builder(
            // padding: EdgeInsets.all(Constants.padding),
            itemCount: listSpending.length,
            itemBuilder: (_, index) {
              MapEntry<DateTime, List<Spending>> entry =
                  listSpending.entries.toList()[index];
              List<Spending> _listSpending = entry.value;
              Color color = Color.fromRGBO(
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255),
                1,
              );
              print(
                  'red: ${color.red}, green: ${color.green}, blue: ${color.blue}');
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          entry.key.formatDDMMYYYY(),
                          style: TextThemeUtil.instance.bodyMedium?.semiBold,
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: Constants.padding),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _listSpending.length,
                    separatorBuilder: (_, __) => SizedBox(
                      height: Constants.spacingBetweenWidget,
                    ),
                    itemBuilder: (context, index) => SpendingItem(
                      spending: _listSpending[index],
                    ),
                  ),
                ],
              );
            },
          );
        }
        return EmptyWidget();
      },
    );
  }
}

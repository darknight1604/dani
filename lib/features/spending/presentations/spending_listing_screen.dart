import 'package:dani/core/constants.dart';
import 'package:dani/core/utils/string_util.dart';
import 'package:dani/core/utils/text_theme_util.dart';
import 'package:dani/features/spending/models/spending.dart';
import 'package:dani/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../applications/spending_listing/spending_listing_bloc.dart';

class SpendingListingScreen extends StatefulWidget {
  const SpendingListingScreen({super.key});

  @override
  State<SpendingListingScreen> createState() => _SpendingListingScreenState();
}

class _SpendingListingScreenState extends State<SpendingListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SpendingListingBloc>(
        create: (context) => SpendingListingBloc(GetIt.I.get())
          ..add(FetchSpendingListingEvent()),
        child: _ScreenBody(),
      ),
    );
  }
}

class _ScreenBody extends StatefulWidget {
  @override
  State<_ScreenBody> createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<_ScreenBody> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print(WidgetsBinding.instance.lifecycleState);
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    super.didChangeAppLifecycleState(appLifecycleState);
    print(appLifecycleState);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpendingListingBloc, SpendingListingState>(
      builder: (context, state) {
        if (state is SpendingListingLoaded) {
          List<Spending> listSpending = state.listSpending;
          return ListView.separated(
            padding: EdgeInsets.all(Constants.padding),
            separatorBuilder: (_, __) => SizedBox(
              height: Constants.spacingBetweenWidget,
            ),
            itemCount: listSpending.length,
            itemBuilder: (_, index) => Container(
              padding: EdgeInsets.all(Constants.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Constants.radius),
                border: Border.all(color: Constants.borderColor),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${tr(LocaleKeys.spendingScreen_cost)}: ',
                        style: TextThemeUtil.instance.bodyLarge,
                      ),
                      Text(
                        listSpending[index].cost.toString(),
                        style: TextThemeUtil.instance.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Constants.padding,
                  ),
                  Row(
                    children: [
                      Text(
                        '${tr(LocaleKeys.common_note)}: ',
                        style: TextThemeUtil.instance.bodyLarge,
                      ),
                      Text(
                        StringUtil.isNullOrEmpty(listSpending[index].note)
                            ? listSpending[index].note.toString()
                            : Constants.empty,
                        style: TextThemeUtil.instance.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return Text('hello-world');
      },
    );
  }
}

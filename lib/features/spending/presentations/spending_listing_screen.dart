import 'package:dani/core/constants.dart';
import 'package:dani/core/utils/extensions/date_time_extension.dart';
import 'package:dani/core/utils/string_util.dart';
import 'package:dani/core/utils/text_theme_util.dart';
import 'package:dani/features/spending/models/spending.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
      body: BlocProvider<SpendingListingBloc>(
        create: (context) => GetIt.I.get<SpendingListingBloc>()
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

class _ScreenBodyState extends State<_ScreenBody> {
  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpendingListingBloc, SpendingListingState>(
      builder: (context, state) {
        if (state is SpendingListingLoaded) {
          if (state.listSpending.isEmpty) {
            return EmptyWidget();
          }
          List<Spending> listSpending = state.listSpending;
          return ListView.separated(
            padding: EdgeInsets.all(Constants.padding),
            separatorBuilder: (_, __) => SizedBox(
              height: Constants.spacingBetweenWidget,
            ),
            itemCount: listSpending.length,
            itemBuilder: (_, index) => SpendingItem(
              spending: listSpending[index],
            ),
          );
        }
        return Text('hello-world');
      },
    );
  }
}

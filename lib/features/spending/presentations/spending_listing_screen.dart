import 'package:dani/core/app_route.dart';
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
            itemCount: listSpending.length + 1,
            itemBuilder: (_, index) {
              if (index == listSpending.length && state.isFinishLoadMore) {
                return SizedBox.shrink();
              }
              if (index == listSpending.length) {
                BlocProvider.of<SpendingListingBloc>(context)
                    .add(LoadMoreSpendingListingEvent());
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              MapEntry<DateTime, List<Spending>> entry =
                  listSpending.entries.toList()[index];
              List<Spending> _listSpending = entry.value;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _TitleGroupListSpendingWidget(
                    title: entry.key.formatDDMMYYYY(),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(
                      Constants.padding,
                      0,
                      Constants.padding,
                      Constants.padding,
                    ),
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

class _TitleGroupListSpendingWidget extends StatelessWidget {
  final String title;
  const _TitleGroupListSpendingWidget({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
          Text(
            title,
            style: TextThemeUtil.instance.bodyMedium?.semiBold,
          ),
          Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

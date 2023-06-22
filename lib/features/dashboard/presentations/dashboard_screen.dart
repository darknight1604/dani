import 'package:dani/core/constants.dart';
import 'package:dani/core/utils/extensions/date_time_extension.dart';
import 'package:dani/core/utils/text_theme_util.dart';
import 'package:dani/features/dashboard/presentations/widgets/pie_chart.dart';
import 'package:dani/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/widgets/total_row_widget.dart';
import '../applications/spending_dashboard/spending_dashboard_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin {
  late int _month;
  late int _year;

  final DateTime _now = DateTime.now();
  late SpendingDashboardBloc _spendingDashboardBloc;

  @override
  void initState() {
    super.initState();
    _month = _now.month;
    _year = _now.year;
    _spendingDashboardBloc = GetIt.I.get<SpendingDashboardBloc>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<SpendingDashboardBloc>(
      create: (context) => _spendingDashboardBloc
        ..add(
          GenerateDataDashboardEvent(_month, _year),
        ),
      child: Scaffold(
        backgroundColor: Constants.scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(Constants.padding),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                Constants.radius,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Constants.padding),
              child: Column(
                children: [
                  Text(
                    tr(
                      LocaleKeys.dashboardScreen_statisticInMonth,
                      args: [
                        _now.monthTitle,
                      ],
                    ),
                    style: TextThemeUtil.instance.titleLarge,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(milliseconds: 100));
                        _spendingDashboardBloc
                            .add(GenerateDataDashboardEvent(_month, _year));
                      },
                      child: ListView(
                        children: [
                          BlocBuilder<SpendingDashboardBloc,
                              SpendingDashboardState>(
                            builder: (context, state) {
                              return TotalRowWidget(
                                title: tr(LocaleKeys.common_total),
                                content: state
                                        is! SpendingPieChartDashboardState
                                    ? Constants.empty
                                    : '${Constants.nf.format(state.spendingPieChartData.total)} ${Constants.currencySymbol}',
                              );
                            },
                          ),
                          PieChartSample(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}

import 'dart:math';

import 'package:dani/core/utils/extensions/text_style_extension.dart';
import 'package:dani/core/utils/iterable_util.dart';
import 'package:dani/core/utils/text_theme_util.dart';
import 'package:dani/core/widgets/empty_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../applications/spending_dashboard/spending_dashboard_bloc.dart';

class PieChartSample extends StatefulWidget {
  const PieChartSample({super.key});

  @override
  State<StatefulWidget> createState() => _PieChartSampleState();
}

class _PieChartSampleState extends State {
  List<int> listIndexColor = [];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: BlocBuilder<SpendingDashboardBloc, SpendingDashboardState>(
        builder: (context, state) {
          if (state is! SpendingPieChartDashboardState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (IterableUtil.isNullOrEmpty(
              state.spendingPieChartData.listCategoryData)) {
            return Center(
              child: EmptyWidget(),
            );
          }
          listIndexColor.clear();
          final spendingPieChartData = state.spendingPieChartData;
          final listCategoryData = spendingPieChartData.listCategoryData;

          List<Color> listColorChart = List.generate(
            listCategoryData.length,
            (_) {
              int indexColor = generateIndexColor();

              return Color(colors[indexColor]);
            },
          );
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: listCategoryData.map(
                        (e) {
                          final isTouched = e.categoryId ==
                              spendingPieChartData.smallest.categoryId;
                          final radius = isTouched ? 60.0 : 50.0;
                          int index = listCategoryData.indexOf(e);
                          Color color = listColorChart[index];
                          return PieChartSectionData(
                            color: color,
                            value: e.percent,
                            title: e.percent.toString(),
                            radius: radius,
                            titleStyle: isTouched
                                ? TextThemeUtil.instance.titleMedium?.semiBold
                                    .copyWith(color: Colors.white)
                                : TextThemeUtil.instance.titleSmall?.semiBold
                                    .copyWith(color: Colors.white),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
              Wrap(
                spacing: 4.0,
                runSpacing: 14.0,
                runAlignment: WrapAlignment.end,
                children: listColorChart.map((color) {
                  int index = listColorChart.indexOf(color);

                  return _Indicator(
                    color: listColorChart[index],
                    title: listCategoryData[index].categoryName ?? StringPool.empty,
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  static List<int> colors = [
    0xFF006064,
    0xFF880E4F,
    0xFF004D40,
    0xFF01579B,
    0xFF9C27B0,
    0xFF673AB7,
    0xFF607D8B,
    0xFF795548,
    0xFF82B1FF,
    0xFFC0CA33,
    0xFFAED581,
    0xFF263238,
  ];

  int generateIndexColor() {
    int indexColor = Random().nextInt(colors.length);
    if (!listIndexColor.contains(indexColor)) {
      listIndexColor.add(indexColor);
      return indexColor;
    }
    return generateIndexColor();
  }
}

class _Indicator extends StatelessWidget {
  final Color color;
  final String title;
  const _Indicator({
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: SizedBox(
            height: 20,
            width: 20,
          ),
        ),
        SizedBox(
          width: 4.0,
        ),
        Flexible(
          child: Text(
            title,
            style: TextThemeUtil.instance.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

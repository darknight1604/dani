part of 'spending_dashboard_bloc.dart';

abstract class SpendingDashboardState extends Equatable {
  const SpendingDashboardState();

  @override
  List<Object> get props => [];
}

class SpendingDashboardInitial extends SpendingDashboardState {}

class SpendingDashboardLoading extends SpendingDashboardState {}

class SpendingPieChartDashboardState extends SpendingDashboardState {
  final SpendingPieChartData spendingPieChartData;

  SpendingPieChartDashboardState(this.spendingPieChartData);
  @override
  List<Object> get props => [spendingPieChartData];
}

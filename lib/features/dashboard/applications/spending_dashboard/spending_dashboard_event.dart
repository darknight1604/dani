part of 'spending_dashboard_bloc.dart';

abstract class SpendingDashboardEvent extends Equatable {
  const SpendingDashboardEvent();

  @override
  List<Object> get props => [];
}

class GenerateDataDashboardEvent extends SpendingDashboardEvent {
  final int month;
  final int year;

  GenerateDataDashboardEvent(this.month, this.year);
  
}

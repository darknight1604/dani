part of 'spending_listing_bloc.dart';

abstract class SpendingListingState extends Equatable {
  const SpendingListingState();

  @override
  List<Object> get props => [];
}

class SpendingListingInitial extends SpendingListingState {}

class SpendingListingLoaded extends SpendingListingState {
  final List<Spending> listSpending;
  SpendingListingLoaded(this.listSpending);
  @override
  List<Object> get props => [listSpending];
}

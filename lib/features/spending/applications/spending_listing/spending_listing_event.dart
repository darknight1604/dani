part of 'spending_listing_bloc.dart';

abstract class SpendingListingEvent extends Equatable {
  const SpendingListingEvent();

  @override
  List<Object> get props => [];
}

class FetchSpendingListingEvent extends SpendingListingEvent {}

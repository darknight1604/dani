part of 'spending_listing_bloc.dart';

abstract class SpendingListingState extends Equatable {
  const SpendingListingState();
  SpendingListingState copyWith() => this;
  @override
  List<Object> get props => [];
}

class SpendingListingInitial extends SpendingListingState {}

class SpendingListingLoaded extends SpendingListingState {
  final Map<DateTime, List<Spending>> listSpending;
  final bool isFinishLoadMore;

  SpendingListingLoaded(this.listSpending, {this.isFinishLoadMore = false});

  @override
  List<Object> get props => [
        listSpending,
        isFinishLoadMore,
      ];

  @override
  SpendingListingState copyWith({bool? isFinishLoadMore}) {
    return SpendingListingLoaded(
      listSpending,
      isFinishLoadMore: isFinishLoadMore ?? this.isFinishLoadMore,
    );
  }
}

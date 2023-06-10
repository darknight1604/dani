import 'package:bloc/bloc.dart';
import 'package:dani/features/spending/bussinesses/spending_business.dart';
import 'package:dani/features/spending/models/spending.dart';
import 'package:equatable/equatable.dart';

part 'spending_listing_event.dart';
part 'spending_listing_state.dart';

class SpendingListingBloc
    extends Bloc<SpendingListingEvent, SpendingListingState> {
  final SpendingBusiness spendingBusiness;

  SpendingListingBloc(
    this.spendingBusiness,
  ) : super(SpendingListingInitial()) {
    on<FetchSpendingListingEvent>((event, emit) async {
      final result = await spendingBusiness.getListSpending();
      emit(SpendingListingLoaded(result));
    });
  }
}

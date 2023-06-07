import 'package:bloc/bloc.dart';
import 'package:dani/features/spending/models/spending.dart';
import 'package:dani/features/spending/services/spending_service.dart';
import 'package:equatable/equatable.dart';

part 'spending_listing_event.dart';
part 'spending_listing_state.dart';

class SpendingListingBloc
    extends Bloc<SpendingListingEvent, SpendingListingState> {
  final SpendingService spendingService;
  SpendingListingBloc(
    this.spendingService,
  ) : super(SpendingListingInitial()) {
    on<FetchSpendingListingEvent>((event, emit) async {
      List<Spending> list = await spendingService.getListSpending();
      emit(SpendingListingLoaded(list));
    });
  }
}

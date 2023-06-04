import 'package:alpha/features/spending/services/spending_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../models/spending_category.dart';

part 'spending_event.dart';
part 'spending_state.dart';

class SpendingBloc extends Bloc<SpendingEvent, SpendingState> {
  final SpendingService _spendingService = GetIt.I.get();
  SpendingBloc() : super(SpendingInitial()) {
    on<FetchSpendingCategoryEvent>((event, emit) async {
      List<SpendingCategory> spendingCategories =
          await _spendingService.getListSpendingCategory();
      emit(
        SpendingLoaded(spendingCategories: spendingCategories),
      );
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/services/local_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LocalService localService;
  HomeCubit(
    this.localService,
  ) : super(HomeInitial());

  Future logout() async {
    final result = await localService.logout();
    if (!result) {
      emit(HomeLogoutFailureState());
      return;
    }
    emit(HomeLogoutSuccessState());
  }
}

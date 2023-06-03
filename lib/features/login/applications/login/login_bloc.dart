import 'package:alpha/core/repositories/local/local_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../services/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService _loginService = LoginService();
  final LocalRepository _localRepository = LocalRepository.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LoginWithGmailEvent>((event, emit) async {
      emit(LoginLoadingState());
      GoogleSignInAccount? googleSignInAcc =
          await _loginService.loginWithGmail();
      if (googleSignInAcc == null) {
        emit(LoginFailState());
        return;
      }
      GoogleSignInAuthentication authen = await googleSignInAcc.authentication;
      if (authen.accessToken == null || authen.accessToken!.isEmpty) {
        emit(LoginFailState());
        return;
      }
      _localRepository.saveToken(authen.accessToken!);
      emit(LoginSuccessState());
    });
  }
}

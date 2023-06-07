import 'package:alpha/dependency_container.dart';
import 'package:alpha/features/login/domains/businesses/login_business.dart';
import 'package:alpha/features/login/services/login_service.dart';
import 'package:get_it/get_it.dart';

class LoginDiContainer extends DiContainer {
  @override
  void setup(GetIt instance) {
    instance.registerLazySingleton<LoginService>(
      () => LoginService(),
    );
    instance.registerLazySingleton<LoginBusiness>(
      () => LoginBusiness(
        localService: instance.get(),
        loginService: instance.get(),
      ),
    );
  }
}

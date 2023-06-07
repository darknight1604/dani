import 'package:alpha/core/services/local_service.dart';
import 'package:alpha/core/utils/string_util.dart';
import 'package:get_it/get_it.dart';

import '../features/login/domains/models/user.dart';

class AppConfig {
  late String? _token;

  AppConfig._internal() {
    _token = null;
  }

  static AppConfig? _instance;

  static AppConfig get instance => _instance ??= AppConfig._internal();

  Future<void> initial() async {
    User? user = await GetIt.I.get<LocalService>().getUser();
    _token = user?.accessToken ?? '';
  }

  bool get isLogged => StringUtil.isNotNullOrEmpty(_token);
}

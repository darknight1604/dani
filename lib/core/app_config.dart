import 'package:alpha/core/services/local_service.dart';
import 'package:alpha/core/utils/string_util.dart';
import 'package:get_it/get_it.dart';

class AppConfig {
  late String? _token;

  AppConfig._internal() {
    _token = null;
  }

  static AppConfig? _instance;

  static AppConfig get instance => _instance ??= AppConfig._internal();

  Future<void> initial() async {
    _token = await GetIt.I.get<LocalService>().fetchToken();
  }

  bool get isLogged => StringUtil.isNotNullOrEmpty(_token);
}

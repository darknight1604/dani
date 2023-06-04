import 'package:alpha/core/services/local_service.dart';
import 'package:alpha/core/utils/string_util.dart';

class AppConfig {
  final LocalService _localService = LocalService.instance;

  late String? _token;

  AppConfig._internal() {
    _token = null;
  }

  static AppConfig? _instance;

  static AppConfig get instance => _instance ??= AppConfig._internal();

  Future<void> initial() async {
    _token = await _localService.fetchToken();
  }

  bool get isLogged => StringUtil.isNotNullOrEmpty(_token);
}

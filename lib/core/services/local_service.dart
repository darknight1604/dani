import 'package:alpha/core/constants.dart';
import 'package:alpha/core/repositories/local/local_repository.dart';

class LocalService {
  LocalService._internal();

  static LocalService? _instance;

  static LocalService get instance => _instance ??= LocalService._internal();

  final LocalRepository _localRepository = LocalRepository.instance;

  void saveToken(String token) async {
    _localRepository.setString(Constants.token, token);
  }

  Future<String> fetchToken() async {
    return _localRepository.getString(Constants.token);
  }
}

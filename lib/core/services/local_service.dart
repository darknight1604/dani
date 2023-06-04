import 'package:alpha/core/constants.dart';
import 'package:alpha/core/repositories/local/local_repository.dart';
import 'package:get_it/get_it.dart';

class LocalService {
  final LocalRepository _localRepository =
      GetIt.instance.get<LocalRepository>();

  void saveToken(String token) async {
    _localRepository.setString(Constants.token, token);
  }

  Future<String> fetchToken() async {
    return _localRepository.getString(Constants.token);
  }
}

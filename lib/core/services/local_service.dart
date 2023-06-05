import 'dart:convert';

import 'package:alpha/core/constants.dart';
import 'package:alpha/core/repositories/local/local_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/login/models/user.dart';

class LocalService {
  final LocalRepository _localRepository =
      GetIt.instance.get<LocalRepository>();

  void saveUser(User user) async {
    _localRepository.setString(Constants.user, jsonEncode(user.toJson()));
  }

  void saveToken(String token) async {
    _localRepository.setString(Constants.token, token);
  }

  Future<String> fetchToken() async {
    return _localRepository.getString(Constants.token);
  }

  Future<User> getUser() async {
    String str = await _localRepository.getString(Constants.user);

    return User.fromJson(jsonDecode(str));
  }
}

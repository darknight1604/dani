import 'dart:convert';

import 'package:alpha/core/constants.dart';
import 'package:alpha/core/repositories/local/local_repository.dart';
import 'package:alpha/core/utils/string_util.dart';
import 'package:get_it/get_it.dart';

import '../../features/login/domains/models/user.dart';

class LocalService {
  final LocalRepository _localRepository =
      GetIt.instance.get<LocalRepository>();

  Future<bool> saveUser(User user) async {
    return await _localRepository.setString(
        Constants.user, jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    String str = await _localRepository.getString(Constants.user);
    if (StringUtil.isNullOrEmpty(str)) return null;
    return User.fromJson(jsonDecode(str));
  }
}

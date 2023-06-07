import 'dart:convert';

import 'package:alpha/core/constants.dart';
import 'package:alpha/core/repositories/local/local_repository.dart';
import 'package:alpha/core/utils/string_util.dart';

import '../../features/login/domains/models/user.dart';

class LocalService {
  final LocalRepository localRepository;

  LocalService(
    this.localRepository,
  );

  Future<bool> saveUser(User user) async {
    return await localRepository.setString(
        Constants.user, jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    String str = await localRepository.getString(Constants.user);
    if (StringUtil.isNullOrEmpty(str)) return null;
    return User.fromJson(jsonDecode(str));
  }

  Future<bool> logout() async {
    final sharePref = await localRepository.getPref();
    return await sharePref.remove(Constants.user);
  }
}

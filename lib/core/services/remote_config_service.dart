import 'package:dani/core/constants.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  Future<bool> isMaintenance() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    return remoteConfig.getBool(JsonKeyConstants.isMaintenance);
  }
}

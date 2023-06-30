import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../constants.dart';

class FirebaseService {
  static Future<void> init() async {
    await Firebase.initializeApp();
    await _initFirebaseRemoteConfig();
  }

  static Future _initFirebaseRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await Future.wait([
      remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 1),
      )),
      remoteConfig.setDefaults(
        {JsonKeyConstants.isMaintenance: false},
      ),
    ]);
  }
}

import 'package:alpha/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  LocalRepository._internal();

  static LocalRepository? _instance;

  static LocalRepository get instance =>
      _instance ??= LocalRepository._internal();

  late SharedPreferences? _prefs;

  void saveToken(String token) async {
    SharedPreferences prefs = await getPref();
    prefs.setString(Constants.token, token);
  }

  Future<String> fetchToken() async {
    SharedPreferences prefs = await getPref();
    return prefs.getString(Constants.token) ?? '';
  }

  Future<SharedPreferences> getPref() async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getString(String key) async {
    SharedPreferences prefs = await _prefs;
    String response = prefs.getString(key);

    return response;
  }

  Future<bool> setString(String key, String value) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
    return true;
  }

  Future<String> getInt(String key) async {
    SharedPreferences prefs = await _prefs;
    String response = prefs.getString(key);

    return response;
  }

  Future<bool> setInt(String key, int value) async {
    SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
    return true;
  }
}

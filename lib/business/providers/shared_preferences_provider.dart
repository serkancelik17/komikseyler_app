import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<String> getString(String key) async {
    SharedPreferences prefs = await _prefs;
    String response = prefs.getString(key);

    return response;
  }

  static Future<bool> set(String key, dynamic value) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString(key, jsonEncode(value));
    return true;
  }
}

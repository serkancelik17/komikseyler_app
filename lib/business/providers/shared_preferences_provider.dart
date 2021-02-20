import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getString(String key) async {
    SharedPreferences prefs = await _prefs;
    String response = prefs.getString(key);

    return response;
  }

  Future<bool> set(String key, dynamic value) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString(key, jsonEncode(value));
    return true;
  }
}

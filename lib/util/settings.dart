import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulid/ulid.dart';

class Settings {
  static String baseUrl = 'https://komikseyler.serkancelik.web.tr';
  static String imageAssetsUrl = Settings.baseUrl + '/assets/images';

  /// Support on iOS, Android and web project
  static Future<String> getUuid() async {
    String uuid;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uuid = prefs.getString('uuid');
    if (uuid == null) {
      uuid = Ulid().toUuid();
      prefs.setString("uuid", uuid);
    }
    // print("uuid:" + uuid);
    return uuid;
  }

  static Widget buildAppBar({title}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      title: Text(title ?? ''),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
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

  static Future<bool> share(String imageUrl) async {
    String imageFullUrl = Settings.imageAssetsUrl + "/" + imageUrl;
    try {
      var response = await http.get(imageFullUrl);
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      File file = new File(join(tempPath, 'shared_image.png'));

      file.writeAsBytesSync(response.bodyBytes);

      Share.shareFiles([file.path]);
    } catch (e) {
      rethrow;
    }
    return true;
  }
}

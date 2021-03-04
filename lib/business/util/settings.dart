import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:komix/business/models/picture.dart';
import 'package:komix/business/util/ad_manager.dart';
import 'package:komix/business/util/config/env.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulid/ulid.dart';

class Settings {
  /// Support on iOS, Android and web project
  static Future<String> getUuid() async {
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    //try {
    if (Platform.isAndroid) {
      try {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } catch (e) {
        throw e;
      }
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      identifier = data.identifierForVendor; //UUID for iOS
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      identifier = prefs.getString('uuid');
      if (identifier == null) {
        identifier = Ulid().toUuid();
        prefs.setString("uuid", identifier);
      }
    }
    return identifier;
    /*   } catch (e) {
      rethrow;
    }*/
  }

  static Widget buildAppBar({title}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      title: Text(title ?? 'Komix'),
    );
  }

  static Future<bool> share({@required Picture picture}) async {
    var imageUri = Uri.parse(Env.imageAssetsUrl + "/" + picture.path);
    try {
      var response = await http.get(imageUri);
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      File file = new File(join(tempPath, 'shared_image.png'));

      file.writeAsBytesSync(response.bodyBytes);

      await Share.shareFiles([file.path]);
      return true;
    } catch (e) {
      return false;
    }
  }

  static getInitialAd(context) {
    if (kIsWeb == false) {
      return AdmobBanner(
        adUnitId: AdManager.bannerAdUnitId,
        adSize: AdmobBannerSize.SMART_BANNER(context),
      );
    } else {
      return Text("");
    }
  }

  static Widget showErrorDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    return AlertDialog(
      title: Text("Bir hata oluştu."),
      content: Text("Bir hatayla karşılaşıldı. Lütfen tekrar deneyiniz."),
      actions: [
        okButton,
      ],
    );
  }
}

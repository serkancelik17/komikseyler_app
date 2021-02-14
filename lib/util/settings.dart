import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:komik_seyler/models/device.dart';
import 'package:komik_seyler/repositories/device_repository.dart';
import 'package:komik_seyler/util/ad_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulid/ulid.dart';

class Settings {
  static String baseUrl = 'https://komikseyler.serkancelik.web.tr';

  /*  static String baseUrl = 'http://komikseyler.serkancelik.web.local'; */

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

  static Future<Device> getDevice() async {
    Device device;
    final DeviceRepository _deviceRepository = DeviceRepository();
    /* device = await _deviceRepository.get(id: 26);*/

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String deviceString = prefs.getString('device');
    if (deviceString != null) {
      // eğer aygıt kayıtlıysa
      device = deviceFromJson(deviceString);
    } else {
      //
      String uuid = Ulid().toUuid();
      device = await _deviceRepository.store(uuid: uuid);
      prefs.setString("device", deviceToJson(device));
    }
    return device;
  }

  static Widget buildAppBar({title}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      title: Text(title ?? 'Komik Şeyler'),
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

  static getBannerAd({String bannerAdUnitId, AdmobBannerSize bannerSize}) {
    if (kIsWeb == false) {
      return Container(
        width: 300,
        child: AdmobBanner(
          adUnitId: bannerAdUnitId ?? AdManager.bannerAdUnitId,
          adSize: bannerSize ?? AdmobBannerSize.BANNER,
        ),
      );
    } else {
      return SizedBox();
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
}

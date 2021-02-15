import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:device_info/device_info.dart';
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
/*  static String baseUrl = 'https://komikseyler.serkancelik.web.tr';*/

  static String baseUrl = 'http://10.0.2.2/komikseyler.serkancelik.web.tr/public';

  static String imageAssetsUrl = Settings.baseUrl + '/assets/images';
  static int pagePictureLimit = 5;

  /// Support on iOS, Android and web project
  static Future<String> getIUuid() async {
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
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
    } catch (e) {
      rethrow;
    }
  }

  static Future<Device> getDevice() async {
    Device device;
    final DeviceRepository _deviceRepository = DeviceRepository();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    try {
      int deviceId = prefs.getInt('deviceId');

      if (deviceId != null) {
        // device onceden kayıtlıysa
        device = await _deviceRepository.get(id: deviceId);
      } else {
        String uuid = await Settings.getIUuid();
        device = await _deviceRepository.store(device: Device(uuid: uuid));
        prefs.setInt("deviceId", device.id);
      }
    } catch (e) {
      throw e;
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

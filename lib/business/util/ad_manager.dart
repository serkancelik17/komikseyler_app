import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdManager {
  Platform platform;

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-2571341208688709~9554327716";
    } else if (Platform.isIOS) {
      return "ca-app-pub-2571341208688709~4101532938";
    } else {
      //throw new UnsupportedError("Unsupported platform");
      return "Unsupported Platform";
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/8865242552"; //test banner unit
      //return "ca-app-pub-2571341208688709/3531844841";
    } else if (Platform.isIOS) {
      return "ca-app-pub-2571341208688709/1475369593";
    } else {
      return "Unsupported Platform";
    }
  }

/*  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-2571341208688709/3303852395";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/3964253750";
    } else {
      return "Unsupported Platform";
    }
  }
*/
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/8673189370";
      //return "ca-app-pub-2571341208688709/8998636399";
    } else if (Platform.isIOS) {
      return "ca-app-pub-2571341208688709/3718389557";
    } else {
      return "Unsupported platform";
    }
  }

  static getBannerAd({String bannerAdUnitId, AdmobBannerSize bannerSize}) {
    if (kIsWeb == false) {
      return AdmobBanner(
        adUnitId: bannerAdUnitId ?? AdManager.bannerAdUnitId,
        adSize: bannerSize ?? AdmobBannerSize.BANNER,
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

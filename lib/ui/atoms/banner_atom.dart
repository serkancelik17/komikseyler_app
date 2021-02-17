import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/util/ad_manager.dart';

class BannerAtom extends StatelessWidget {
  final String bannerAdUnitId;
  final AdmobBannerSize bannerSize;

  BannerAtom({this.bannerSize, this.bannerAdUnitId});

  @override
  Widget build(BuildContext context) {
    return AdmobBanner(
      adUnitId: this.bannerAdUnitId ?? AdManager.bannerAdUnitId,
      adSize: this.bannerSize ?? AdmobBannerSize.BANNER,
    );
  }
}

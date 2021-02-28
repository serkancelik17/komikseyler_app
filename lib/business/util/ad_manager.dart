import 'dart:async';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/util/settings.dart';

class AdManager {
  Platform platform;
  Set<String> _productIds = {'subscription_yearly', 'subscription_three_month', 'subscription_six_month', 'subscription_one_month'};
  InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  List<ProductDetails> _products = [];
  Device _device;

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

  Future<bool> checkShowingAd() async {
    await _getDevice();
    if (!kIsWeb && (DateTime.now().isBefore(_device?.option?.adsShowAfter ?? DateTime.now().subtract(Duration(days: 1))))) {
      return false;
    } else {
      return true;
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

  Future<Device> removeAds({BuildContext ctx, Duration duration}) async {
    String adsShowAfter = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now().add(duration));
    _device.option = await _device.option.updateOrCreate({'device_uuid': await Settings.getUuid()}, {'ads_show_after': adsShowAfter});
    this.checkShowingAd();
    return _device;
  }

  listenToPurchaseUpdated(BuildContext ctx, List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // show progress bar or something
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // show error message or failure icon
          showPaymentErrorAlertDialog(ctx);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          this.removeAds(ctx: ctx, duration: Duration(days: 365 * 100));
          showPaymentSuccessAlertDialog(ctx);
          // show success message and deliver the product.
        }
      }
    });
  }

  buyProduct() {
    if (_products.length > 0) {
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: _products[0]);
      _connection.buyConsumable(purchaseParam: purchaseParam);
    } else {
      print("HATA: Product bulunamadı");
    }
  }

  showPaymentErrorAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog(
      title: Text("Ödeme Alınamadı. :("),
      content: Text("Bir hatayla karşılaşıldı. Tekrar deneyiniz."),
      actions: [
        okButton,
      ],
    );
  }

  initStoreInfo() async {
    ProductDetailsResponse productDetailResponse = await _connection.queryProductDetails(this._productIds);
    if (productDetailResponse.error == null) {}
    _products = productDetailResponse.productDetails;
  }

  showPaymentSuccessAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog(
      title: Text("Ödeme Alındı."),
      content: Text("Tüm reklamlar kaldırıldı. Ödeme için teşekkürler."),
      actions: [
        okButton,
      ],
    );
  }

  Future<Device> _getDevice() async {
    return _device ??= await Device().find(id: await Settings.getUuid());
  }
}

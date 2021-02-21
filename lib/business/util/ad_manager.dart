import 'dart:async';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';

class AdManager {
  Platform platform;
  final DeviceRepository deviceRepository;
  final _productIds = {'subscription_yearly'};
  InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  List<ProductDetails> _products = [];

  AdManager({deviceRepository}) : deviceRepository = deviceRepository ?? DeviceRepository();

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

  Future<bool> showAd() async {
    final Device _device = await deviceRepository.get();
    if (!kIsWeb && (DateTime.now().isBefore(_device?.option?.adsShowAfter ?? DateTime.now().subtract(Duration(days: 1))))) {
      return false;
    }
    return true;
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

  removeAds(BuildContext ctx) async {
    final Device _device = await deviceRepository.get();

    //@TODO device.option icine aktarilacak.
    _device.option.update();
    //await deviceRepository.optionUpdate(option:, patch: {'ads_show_after': DateTime.now().add(Duration(days: 365 * 100))});
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
          this.removeAds(ctx);
          // show success message and deliver the product.
          showPaymentSuccessAlertDialog(ctx);
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
    Widget okButton = FlatButton(
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
    ProductDetailsResponse productDetailResponse = await _connection.queryProductDetails(_productIds);
    if (productDetailResponse.error == null) {
      //setState(() {
      _products = productDetailResponse.productDetails;
      // });
    }
  }

  showPaymentSuccessAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
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
}

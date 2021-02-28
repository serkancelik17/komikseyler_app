import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/business/util/ad_manager.dart';
import 'package:komik_seyler/ui/templates/views_template.dart';

class ViewsPage extends StatefulWidget {
  final SectionMixin section;
  ViewsPage({@required this.section});

  @override
  _ViewsPageState createState() => _ViewsPageState();
}

class _ViewsPageState extends State<ViewsPage> {
  int pictureChangeCount = 0;
  List<ViewMixin> views;
  int page = 1;
  ViewMixin activeView;
  AdmobReward reward;
  AdManager _adManager = AdManager();
  StreamSubscription<List<PurchaseDetails>> subscription;

  @override
  void initState() {
    //In APP Purchase
    Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;
    subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _adManager.listenToPurchaseUpdated(context, purchaseDetailsList);
    }, onDone: () {
      subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    _adManager.initStoreInfo();

    reward = AdmobReward(
      adUnitId: AdManager.rewardedAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) async {
        if (event == AdmobAdEvent.closed) reward.load();
        handleRewardAdEvent(context, event, args);
      },
    );
    reward.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewsTemplate(widget.section, _adManager, activeView, reward);
  }

  Future<void> handleRewardAdEvent(BuildContext ctx, AdmobAdEvent event, Map<String, dynamic> args) async {
    print("Admob event is " + event.toString());
    switch (event) {
      /* case AdmobAdEvent.loaded:
        showSnackBar('New Admob $adType Ad loaded!');
        break;*/
      /*case AdmobAdEvent.opened:
        showSnackBar('Admob $adType Ad opened!');
        break;*/
      case AdmobAdEvent.closed:
        print("reward kapatildi");
        break;
      /* case AdmobAdEvent.failedToLoad:
        showSnackBar('Admob $adType failed to load. :(');
        break;*/
      case AdmobAdEvent.rewarded:
        await _adManager.removeAds(ctx: ctx, duration: Duration(minutes: 30));
        print("removeAds reklamlar kaldirildi.");
        showAlertDialog(ctx);
        break;
      default:
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    reward.dispose();
    super.dispose();
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = ElevatedButton(
    child: Text("Teşekkürler"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Tebrikler"),
    content: Text("30 dakika reklam görmeyeceksiniz."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

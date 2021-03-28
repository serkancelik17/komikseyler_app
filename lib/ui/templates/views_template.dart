import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:komix/business/models/ad.dart';
import 'package:komix/business/models/device/log.dart';
import 'package:komix/business/models/mixins/section_mixin.dart';
import 'package:komix/business/models/mixins/view_mixin.dart';
import 'package:komix/business/models/picture.dart';
import 'package:komix/business/util/ad_manager.dart';
import 'package:komix/ui/molecules/banner_buttons_molecule.dart';
import 'package:komix/ui/molecules/banner_molecule.dart';
import 'package:komix/ui/molecules/center_text_molecule.dart';
import 'package:komix/ui/molecules/dialog_molecule.dart';
import 'package:komix/ui/molecules/title_color_molecule.dart';
import 'package:komix/ui/organisms/app_bar_organism.dart';
import 'package:komix/ui/organisms/bottom_navigation_bar_organism.dart';
import 'package:komix/ui/organisms/custom_slider_organism.dart';
import 'package:komix/ui/themes/custom_colors.dart';

class ViewsTemplate extends StatefulWidget {
  final SectionMixin section;

  ViewsTemplate(this.section);

  @override
  _ViewsTemplateState createState() => _ViewsTemplateState();
}

class _ViewsTemplateState extends State<ViewsTemplate> with WidgetsBindingObserver {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdManager adManager = AdManager();
  ViewMixin activeView;
  AdmobReward reward;
  StreamSubscription<List<PurchaseDetails>> subscription;
  Log _log;
  Widget _smartBanner = Text("");

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //In APP Purchase
      Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;
      subscription = purchaseUpdated.listen((purchaseDetailsList) {
        adManager.listenToPurchaseUpdated(context, purchaseDetailsList);
      }, onDone: () {
        showPaymentSuccessAlertDialog(context);
        subscription.cancel();
      }, onError: (error) {
        // handle error here.
      });
    });

    adManager.initStoreInfo();

    reward = AdmobReward(
      adUnitId: AdManager.rewardedAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) async {
        if (event == AdmobAdEvent.closed) reward.load();
        handleRewardAdEvent(context, event, args);
      },
    );
    WidgetsBinding.instance.addObserver(this);
    _buildSmallBanner();
    reward.load();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        goToBack();
        return true;
      },
      child: Scaffold(
        key: scaffoldState,
        appBar: AppBarOrganism(
          leading: IconButton(icon: Icon(Icons.west), onPressed: () => goToBack()),
          title: CenterTextMolecule(
              child: TitleColorMolecule(
            text: widget.section.getTitle() ?? '{{title}}',
            colors: [
              Colors.black,
              CustomColors.purple,
            ],
          )),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: CustomSliderOrganism(
                  section: widget.section,
                  viewChanged: (activeView) {
                    _buildSmallBanner();
                    setState(() {
                      this.activeView = activeView;
                    });
                  },
                  logChanged: (changedLog) {
                    _log = changedLog;
                  },
                  adManager: adManager,
                ),
              ),
              _smartBanner
            ],
          ),
        ),
        bottomNavigationBar: (activeView is Picture) ? BottomNavigationBarOrganism(context: context, activeView: activeView) : null,
      ),
    );
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
        await adManager.removeAds(ctx: ctx, duration: Duration(minutes: 30));
        _logUpdate(); // Logu kaydet
        print("removeAds reklamlar kaldirildi.");
        DialogMolecule.showAlertDialog(ctx, () => Navigator.of(context).popAndPushNamed("/sections", arguments: [widget.section]));
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    subscription.cancel();
    reward.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    _logUpdate();
  }

  Future<void> _buildSmallBanner() async {
    try {
      bool _checkShowingAd = await adManager.checkShowingAd();
      if (_checkShowingAd) {
        if (activeView is Ad) {
          _smartBanner = BannerButtonsMolecule(adManager, reward);
        } else {
          _smartBanner = BannerMolecule();
        }
      } else {
        _smartBanner = Text("");
      }
    } catch (e) {}
  }

  void _logUpdate() {
    if (_log != null) _log.update();
  }

  void goToBack() {
    _logUpdate();
    Navigator.of(context).pop();
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
    return AlertDialog(
      title: Text("Ödeme Alındı."),
      content: Text("Teşekkürler. Satın aldığınız süre kadar reklam göstermeyeceğiz."),
      actions: [
        okButton,
      ],
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:komik_seyler/business/models/ad.dart';
import 'package:komik_seyler/business/models/category.dart' as Local;
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/util/ad_manager.dart';
import 'package:komik_seyler/ui/atoms/button_atom.dart';
import 'package:komik_seyler/ui/molecules/banner_molecule.dart';
import 'package:komik_seyler/ui/molecules/button_with_icon_molecule.dart';
import 'package:komik_seyler/ui/molecules/center_text_molecule.dart';
import 'package:komik_seyler/ui/molecules/title_color_molecule.dart';
import 'package:komik_seyler/ui/organisms/app_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/bottom_navigation_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/custom_slider_organism.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class ViewsTemplate extends StatefulWidget {
  final SectionMixin section;

  ViewsTemplate({@required SectionMixin section, adManager}) : section = section ?? Local.Category(id: 1, name: '{title}');

  @override
  _ViewsTemplateState createState() => _ViewsTemplateState();
}

class _ViewsTemplateState extends State<ViewsTemplate> {
  int pictureChangeCount = 0;
  List<ViewMixin> views;
  int page = 1;
  ViewMixin activeView;
  AdmobReward rewardAd;
  AdManager _adManager = AdManager();
  StreamSubscription<List<PurchaseDetails>> subscription;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

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

    rewardAd = AdmobReward(
      adUnitId: AdManager.rewardedAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) async {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleRewardAdEvent(context, event, args);
      },
    );
    rewardAd.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBarOrganism(
        leading: IconButton(icon: Icon(Icons.west), onPressed: () => Navigator.of(context).pop(widget.section)),
        title: CenterMolecule(TitleColorMolecule(
          text: widget.section.getTitle(),
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
              child: CustomSliderOrganism(_adManager, section: widget.section, viewChanged: (activeView) {
                setState(() {
                  this.activeView = activeView;
                });
              }),
            ),
            (/*_adManager.checkShowingAd()*/ true ? ((activeView is Ad) ? getAdButtons() : BannerMolecule()) : Text("")),
          ],
        ),
      ),
      bottomNavigationBar: (activeView is Picture) ? BottomNavigationBarOrganism(context: context, activeView: activeView) : null,
    );
  }

  Column getAdButtons() {
    List<ButtonAtom> buttons = [];

    buttons.add(ButtonWithIconMolecule(
      onTap: () {
        _adManager.buyProduct();
      },
      child: Text('Reklamları Kaldır'),
      icon: FaIcon((Platform.isAndroid) ? FontAwesomeIcons.googlePay : FontAwesomeIcons.applePay),
    ));

    buttons.add(ButtonWithIconMolecule(
      onTap: () async {
        if (await rewardAd.isLoaded) {
          rewardAd.show();
        }
      },
      child: Text('30 Dakika Reklam Gösterme'),
      icon: FaIcon(FontAwesomeIcons.ad),
    ));

    return Column(children: buttons);
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
    rewardAd.dispose();
    super.dispose();
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
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

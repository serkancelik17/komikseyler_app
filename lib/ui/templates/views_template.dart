import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/business/models/category.dart' as Local;
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/util/ad_manager.dart';
import 'package:komik_seyler/ui/atoms/button_atom.dart';
import 'package:komik_seyler/ui/molecules/button_with_icon_molecule.dart';
import 'package:komik_seyler/ui/molecules/center_text_molecule.dart';
import 'package:komik_seyler/ui/molecules/text_one_word_two_color_molecule.dart';
import 'package:komik_seyler/ui/organisms/app_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/bottom_navigation_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/custom_slider_organism.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class ViewsTemplate extends StatefulWidget {
  final SectionAbstract section;
  final AdManager adManager;

  ViewsTemplate({@required SectionAbstract section, adManager})
      : section = section ?? Local.Category(id: 1, name: '{title}'),
        adManager = adManager ?? AdManager();

  @override
  _ViewsTemplateState createState() => _ViewsTemplateState();
}

class _ViewsTemplateState extends State<ViewsTemplate> {
  int pictureChangeCount = 0;
  List<ViewAbstract> views;
  int page = 1;
  ViewAbstract activeView;
  AdmobReward rewardAd;
  AdManager _adManager = AdManager();
  bool _showAd = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _showAd = await _adManager.showAd();
    });

    rewardAd = AdmobReward(
      adUnitId: AdManager.rewardedAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
      },
    );
    rewardAd.load();

    Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;
    widget.adManager.subscription = purchaseUpdated.listen((purchaseDetailsList) {
      widget.adManager.listenToPurchaseUpdated(context, purchaseDetailsList);
    }, onDone: () {
      widget.adManager.subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    widget.adManager.initStoreInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOrganism(
        leading: IconButton(icon: Icon(Icons.west), onPressed: () => Navigator.of(context).pop(widget.section)),
        title: CenterMolecule(TextOneWordTwoColorMolecule(
          text: widget.section.getTitle(),
          colors: [
            Colors.black,
            CustomColors.purple,
          ],
        )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSliderOrganism(
              section: widget.section,
              viewChanged: (activeView) {
                setState(() {
                  this.activeView = activeView;
                });
              }),
          // //(DateTime.now().isAfter(widget.device?.option?.adsShowAfter ?? DateTime.now().add(Duration(days: 1)))) ?
        ],
      ),
      bottomNavigationBar: (activeView is Picture) ? BottomNavigationBarOrganism(context: context, activeView: activeView) : null,
    );
  }

  Column getAdButtons() {
    List<ButtonAtom> buttons = [];

    buttons.add(ButtonWithIconMolecule(
      onTap: () {
        widget.adManager.buyProduct();
      },
      child: Text('Reklamları Kaldır'),
      icon: FaIcon(FontAwesomeIcons.ad),
    ));

    buttons.add(ButtonWithIconMolecule(
      onTap: () async {
        if (await rewardAd.isLoaded) {
          rewardAd.show();
        }
      },
      child: Text('1 reklam izle 1 saat reklam görme.'),
      icon: FaIcon(FontAwesomeIcons.ad),
    ));

    return Column(children: buttons);
  }
}

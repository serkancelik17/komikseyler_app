import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/ad.dart';
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/util/ad_manager.dart';
import 'package:komik_seyler/ui/molecules/banner_buttons_molecule.dart';
import 'package:komik_seyler/ui/molecules/banner_molecule.dart';
import 'package:komik_seyler/ui/molecules/center_text_molecule.dart';
import 'package:komik_seyler/ui/molecules/dialog_molecule.dart';
import 'package:komik_seyler/ui/molecules/title_color_molecule.dart';
import 'package:komik_seyler/ui/organisms/app_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/bottom_navigation_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/custom_slider_organism.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class ViewsTemplate extends StatefulWidget {
  final SectionMixin section;
  final AdManager adManager;
  final ViewMixin activeView;

  ViewsTemplate(this.section, this.adManager, this.activeView);

  @override
  _ViewsTemplateState createState() => _ViewsTemplateState(activeView);
}

class _ViewsTemplateState extends State<ViewsTemplate> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  ViewMixin activeView;
  AdmobReward reward;
  Widget _smartBanner = Text("");

  _ViewsTemplateState(this.activeView);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    reward = AdmobReward(
      adUnitId: AdManager.rewardedAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) async {
        if (event == AdmobAdEvent.closed) reward.load();
        handleRewardAdEvent(context, event, args);
      },
    );
    buildSmallBanner();
    reward.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBarOrganism(
        leading: IconButton(icon: Icon(Icons.west), onPressed: () => Navigator.of(context).pop(widget.section)),
        title: CenterMolecule(TitleColorMolecule(
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomSliderOrganism(
                section: widget.section,
                viewChanged: (activeView) {
                  buildSmallBanner();
                  setState(() {
                    this.activeView = activeView;
                  });
                }),
            _smartBanner
          ],
        ),
      ),
      bottomNavigationBar: (activeView is Picture) ? BottomNavigationBarOrganism(context: context, activeView: activeView) : null,
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
        await widget.adManager.removeAds(ctx: ctx, duration: Duration(minutes: 30));
        print("removeAds reklamlar kaldirildi.");
        DialogMolecule.showAlertDialog(ctx);
        return Navigator.of(context).pushReplacementNamed('/sections', arguments: [widget.section]);
        break;
      default:
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    reward.dispose();
    super.dispose();
  }

  Future<void> buildSmallBanner() async {
    bool _checkShowingAd = await widget.adManager.checkShowingAd();
    _smartBanner = _checkShowingAd ? ((activeView is Ad) ? BannerButtonsMolecule(widget.adManager, reward) : BannerMolecule()) : Text("");
  }
}

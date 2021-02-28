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
import 'package:komik_seyler/ui/molecules/title_color_molecule.dart';
import 'package:komik_seyler/ui/organisms/app_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/bottom_navigation_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/custom_slider_organism.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class ViewsTemplate extends StatefulWidget {
  final SectionMixin section;
  final AdManager adManager;
  final ViewMixin activeView;
  final AdmobReward reward;

  ViewsTemplate(this.section, this.adManager, this.activeView, this.reward);

  @override
  _ViewsTemplateState createState() => _ViewsTemplateState(activeView);
}

class _ViewsTemplateState extends State<ViewsTemplate> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  ViewMixin activeView;

  _ViewsTemplateState(this.activeView);

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
                  setState(() {
                    this.activeView = activeView;
                  });
                }),
            (/*_adManager.checkShowingAd()*/ true ? ((activeView is Ad) ? BannerButtonsMolecule(widget.adManager, widget.reward) : BannerMolecule()) : Text("")),
          ],
        ),
      ),
      bottomNavigationBar: (activeView is Picture) ? BottomNavigationBarOrganism(context: context, activeView: activeView) : null,
    );
  }
}

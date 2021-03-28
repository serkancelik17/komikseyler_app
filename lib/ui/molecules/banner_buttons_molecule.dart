import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komix/business/util/ad_manager.dart';
import 'package:komix/ui/atoms/button_atom.dart';
import 'package:komix/ui/atoms/center_atom.dart';
import 'package:komix/ui/atoms/row_atom.dart';
import 'package:komix/ui/atoms/text_atom.dart';
import 'package:komix/ui/molecules/button_with_icon_molecule.dart';

class BannerButtonsMolecule extends StatelessWidget {
  final AdManager adManager;
  final AdmobReward reward;

  BannerButtonsMolecule(this.adManager, this.reward);

  @override
  Widget build(BuildContext context) {
    Map _buttonList = {0: '1 Ay', 2: "3 Ay", 1: "6 Ay", 3: "1 Yıl"};

    List<ButtonAtom> inAppButtons = [];

    _buttonList.forEach((index, value) {
      inAppButtons.add(ButtonAtom(
        onPressed: () {
          adManager.buyProduct(index);
        },
        child: Text(value),
      ));
    });

    var button30Minutes = ButtonWithIconMolecule(
      onTap: () async {
        if (await reward.isLoaded) {
          reward.show();
        }
      },
      label: Text('30 Dakika'),
      icon: FaIcon(FontAwesomeIcons.ad),
    );

    var _adRow1 = RowAtom(children: [inAppButtons[0], inAppButtons[1], inAppButtons[2], inAppButtons[3]], mainAxisAlignment: MainAxisAlignment.spaceEvenly);

    return Column(children: [
      Center(child: TextAtom(text: "Reklam Gösterme")),
      _adRow1,
      CenterAtom(
        child: TextAtom(text: 'veya'),
      ),
      button30Minutes,
    ]);
  }
}

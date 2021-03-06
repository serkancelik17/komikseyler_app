import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komix/business/util/ad_manager.dart';
import 'package:komix/ui/atoms/button_atom.dart';
import 'package:komix/ui/molecules/button_with_icon_molecule.dart';

class BannerButtonsMolecule extends StatelessWidget {
  final AdManager adManager;
  final AdmobReward reward;

  BannerButtonsMolecule(this.adManager, this.reward);

  @override
  Widget build(BuildContext context) {
    List<ButtonAtom> buttons = [];

    buttons.add(ButtonWithIconMolecule(
      onTap: () {
        adManager.buyProduct();
      },
      label: Text('Reklamları Kaldır'),
      icon: FaIcon((Platform.isAndroid)
          ? FontAwesomeIcons.googlePay
          : FontAwesomeIcons.applePay),
    ));

    buttons.add(ButtonWithIconMolecule(
      onTap: () async {
        if (await reward.isLoaded) {
          reward.show();
        }
      },
      label: Text('30 Dakika Reklam Gösterme'),
      icon: FaIcon(FontAwesomeIcons.ad),
    ));
    return Column(children: buttons);
  }
}

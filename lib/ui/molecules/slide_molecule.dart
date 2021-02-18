import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/business/models/ad.dart';
import 'package:komik_seyler/business/util/settings.dart';
import 'package:komik_seyler/ui/atoms/banner_atom.dart';
import 'package:komik_seyler/ui/atoms/container_atom.dart';
import 'package:komik_seyler/ui/atoms/image_network_atom.dart';
import 'package:komik_seyler/ui/molecules/rounded_container_molecule.dart';

class SlideMolecule extends StatelessWidget {
  final ViewAbstract view;

  SlideMolecule({@required this.view});

  @override
  Widget build(BuildContext context) {
    return RoundedContainerMolecule(
      child: ContainerAtom(
        child: (view is Ad)
            ? BannerAtom(bannerSize: AdmobBannerSize.MEDIUM_RECTANGLE)
            : ImageNetworkAtom(
                url: Settings.imageAssetsUrl + "/" + view.getPath(),
              ),
      ),
    );
  }
}

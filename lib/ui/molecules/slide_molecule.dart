import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:komik_seyler/business/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/business/models/ad.dart';
import 'package:komik_seyler/business/util/settings.dart';
import 'package:komik_seyler/ui/atoms/banner_atom.dart';
import 'package:komik_seyler/ui/molecules/rounded_container_molecule.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class SlideMolecule extends StatelessWidget {
  final ViewAbstract view;

  SlideMolecule({@required this.view});

  @override
  Widget build(BuildContext context) {
    return RoundedContainerMolecule(
      child: (view is Ad)
          ? BannerAtom(bannerSize: AdmobBannerSize.MEDIUM_RECTANGLE)
          : FullScreenWidget(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PinchZoom(
                  image: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: Settings.imageAssetsUrl + "/" + view.getPath(),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )

      /*PinchZoom(
              image: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: Settings.imageAssetsUrl + "/" + view.getPath(),
              ),
            )*/
      ,
    );
  }
}

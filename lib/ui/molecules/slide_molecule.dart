import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:komik_seyler/business/models/ad.dart';
import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/config/env.dart';
import 'package:komik_seyler/ui/atoms/banner_atom.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class SlideMolecule extends StatelessWidget {
  final ViewMixin view;

  SlideMolecule({@required this.view});

  @override
  Widget build(BuildContext context) {
    return (view is Ad)
        ? BannerAtom(bannerSize: AdmobBannerSize.MEDIUM_RECTANGLE)
        : FullScreenWidget(
            child: PinchZoom(
              image: Container(
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: Env.imageAssetsUrl + "/" + view.path,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
  }
}

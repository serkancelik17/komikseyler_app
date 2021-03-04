import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:komix/business/models/ad.dart';
import 'package:komix/business/models/mixins/view_mixin.dart';
import 'package:komix/business/util/config/env.dart';
import 'package:komix/ui/atoms/banner_atom.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class SlideMolecule extends StatelessWidget {
  final ViewMixin view;

  SlideMolecule({@required this.view});

  @override
  Widget build(BuildContext context) {
    return (view is Ad)
        ? BannerAtom(bannerSize: AdmobBannerSize.MEDIUM_RECTANGLE)
        : Container(
            // child: FullScreenWidget(
            child: PinchZoom(
              image: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: Env.imageAssetsUrl + "/" + view.path,
                fit: BoxFit.contain,
              ),
              /* imageUrl:
                      placeholder: (context, url) => CenterAtom(child: CircularProgressIndicatorAtom()),
                      errorWidget: (context, url, error) => IconAtom(icon: Icons.error),
                    ),*/
            ),
            // ),
          );
  }
}

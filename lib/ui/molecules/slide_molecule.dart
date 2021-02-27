import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:komik_seyler/business/config/env.dart';
import 'package:komik_seyler/business/models/ad.dart';
import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/ui/atoms/banner_atom.dart';
import 'package:komik_seyler/ui/atoms/center_atom.dart';
import 'package:komik_seyler/ui/atoms/circular_progress_indicator_atom.dart';
import 'package:komik_seyler/ui/atoms/icon_atom.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class SlideMolecule extends StatelessWidget {
  final ViewMixin view;

  SlideMolecule({@required this.view});

  @override
  Widget build(BuildContext context) {
    return (view is Ad)
        ? BannerAtom(bannerSize: AdmobBannerSize.MEDIUM_RECTANGLE)
        : Container(
            child: FullScreenWidget(
              child: PinchZoom(
                image: CachedNetworkImage(
                  imageUrl: Env.imageAssetsUrl + "/" + view.path,
                  placeholder: (context, url) => CenterAtom(child: CircularProgressIndicatorAtom()),
                  errorWidget: (context, url, error) => IconAtom(icon: Icons.error),
                ),
              ),
            ),
          );
  }
}

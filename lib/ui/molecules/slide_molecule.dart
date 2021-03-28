import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:komix/business/models/ad.dart';
import 'package:komix/business/models/mixins/view_mixin.dart';
import 'package:komix/business/util/config/env.dart';
import 'package:komix/ui/atoms/banner_atom.dart';

class SlideMolecule extends StatelessWidget {
  final ViewMixin view;

  SlideMolecule({@required this.view});

  @override
  Widget build(BuildContext context) {
    return (view is Ad)
        ? Container(
            width: 300,
            height: 250,
            child: BannerAtom(bannerSize: AdmobBannerSize.MEDIUM_RECTANGLE),
          )
        : Container(
            // child: FullScreenWidget(
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              placeholderScale: 1.75,
              image: Env.imageAssetsUrl + "/" + view.path,
            ),
            // ),
          );
  }
}

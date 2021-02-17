import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/models/ad.dart';
import 'package:komik_seyler/ui/atoms/banner_atom.dart';
import 'package:komik_seyler/ui/atoms/container_atom.dart';
import 'package:komik_seyler/ui/atoms/image_network_atom.dart';
import 'package:komik_seyler/util/settings.dart';

class Slide extends StatelessWidget {
  final ViewAbstract view;

  Slide({@required this.view});

  @override
  Widget build(BuildContext context) {
    return ContainerAtom(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: (view is Ad)
          ? BannerAtom(bannerSize: AdmobBannerSize.MEDIUM_RECTANGLE)
          : ImageNetworkAtom(
              url: Settings.imageAssetsUrl + "/" + view.getPath(),
            ),
    );
  }
}

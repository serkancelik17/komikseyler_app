import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

mixin SectionMixin {
  int viewCount;

  int getId();
  String getTitle();
  String getUniqueName();
  double getPercent();
  Map<String, dynamic> sectionImgMap = {
    'category1': {'icon': FontAwesomeIcons.solidComments},
    'category2': {'icon': FontAwesomeIcons.venusMars}, //+18
    'category3': {'icon': FontAwesomeIcons.images},
    'category4': {'icon': FontAwesomeIcons.camera},
    'category5': {'icon': FontAwesomeIcons.film},
    'category6': {'icon': FontAwesomeIcons.laughBeam},
    'action1': {'icon': FontAwesomeIcons.solidHeart, 'color': CustomColors.lightRed},
    'action2': {'icon': FontAwesomeIcons.solidStar, 'color': CustomColors.lightYellow},
    'action5': {'icon': FontAwesomeIcons.share, 'color': CustomColors.lightBlue},
  };

  SectionMixin setViewCount(int viewCount);
  bool calculatePercent();

  IconData getIcon() {
    return _getFaIcon();
  }

  Color getColor() {
    return sectionImgMap[this.getUniqueName()]['color'] ?? CustomColors.purple;
  }

  IconData _getFaIcon() {
    return sectionImgMap[this.getUniqueName()]['icon'] ?? FontAwesomeIcons.folderOpen;
  }
}

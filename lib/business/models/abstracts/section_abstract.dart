import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komik_seyler/business/repositories/abstracts/repository_abstract.dart';

abstract class SectionAbstract {
  int getId();
  String getTitle();
  String getUniqueName();
  double getPercent();
  SectionAbstract setViewCount(int viewCount);
  bool calculatePercent();

  IconData getIcon() {
    return _getFaIcon();
  }

  RepositoryAbstract getRepository();

  IconData _getFaIcon() {
    Map<String, dynamic> sectionImgMap = {
      'category1': {'icon': FontAwesomeIcons.solidComments},
      'category2': {'icon': FontAwesomeIcons.venusMars}, //+18
      'category3': {'icon': FontAwesomeIcons.images},
      'category4': {'icon': FontAwesomeIcons.camera},
      'category5': {'icon': FontAwesomeIcons.film},
      'category6': {'icon': FontAwesomeIcons.laughBeam},
      'action1': {'icon': FontAwesomeIcons.heart, 'color': Colors.red},
      'action2': {'icon': FontAwesomeIcons.star, 'color': Colors.blue},
    };
    return sectionImgMap[this.getUniqueName()]['icon'] ?? FontAwesomeIcons.folderOpen;
  }
}

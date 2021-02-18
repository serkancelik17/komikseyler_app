import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komik_seyler/business/repositories/abstracts/repository_abstract.dart';

abstract class SectionAbstract {
  int getId();
  String getTitle();
  String getUniqueName();

  FaIcon getIcon() {
    return getFaIcon();
  }

  RepositoryAbstract getRepository();

  FaIcon getFaIcon() {
    Map<String, dynamic> sectionImgMap = {
      'category1': {'icon': FontAwesomeIcons.comments},
      'category2': {'icon': FontAwesomeIcons.venusMars}, //+18
      'category3': {'icon': FontAwesomeIcons.images},
      'category4': {'icon': FontAwesomeIcons.camera},
      'category5': {'icon': FontAwesomeIcons.film},
      'category6': {'icon': FontAwesomeIcons.laughSquint},
      'action1': {'icon': FontAwesomeIcons.heart, 'color': Colors.red},
      'action2': {'icon': FontAwesomeIcons.star, 'color': Colors.blue},
    };
    return FaIcon(sectionImgMap[this.getUniqueName()]['icon'] ?? FontAwesomeIcons.folderOpen, size: 30, color: sectionImgMap[this.getUniqueName()]['color'] ?? null);
  }
}

import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/atoms/center_atom.dart';

class AppBarOrganism extends AppBar {
  final Widget title;
  final double elevation = 0;

  AppBarOrganism({@required Widget title}) : title = CenterAtom(child: (title != null ? title : "{title}"));
}

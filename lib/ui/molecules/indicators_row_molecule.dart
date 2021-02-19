import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/ui/atoms/indicatior_atom.dart';

class IndicatorsRowMolecule extends StatelessWidget {
  final List<ViewAbstract> views;
  final ViewAbstract activeView;

  IndicatorsRowMolecule({@required this.views, @required this.activeView});

  @override
  Widget build(BuildContext context) {
    List<ViewAbstract> screenViews = views;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: screenViews.map((view) {
        bool active = (view == activeView);
        return IndicatorAtom(active: active);
      }).toList(),
    );
  }
}

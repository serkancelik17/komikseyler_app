import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/viewable.dart';
import 'package:komik_seyler/ui/atoms/indicatior_atom.dart';

class IndicatorsRowMolecule extends StatelessWidget {
  final List<Viewable> views;
  final Viewable activeView;

  IndicatorsRowMolecule({@required this.views, @required this.activeView});

  @override
  Widget build(BuildContext context) {
    List<Viewable> screenViews = views;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: screenViews.map((view) {
        bool active = (view == activeView);
        return IndicatorAtom(active: active);
      }).toList(),
    );
  }
}

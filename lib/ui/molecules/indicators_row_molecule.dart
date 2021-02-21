import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/ui/atoms/indicatior_atom.dart';

class IndicatorsRowMolecule extends StatelessWidget {
  final List<ViewMixin> views;
  final ViewMixin activeView;

  IndicatorsRowMolecule({@required this.views, @required this.activeView});

  @override
  Widget build(BuildContext context) {
    List<ViewMixin> screenViews = views;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: screenViews.map((view) {
        bool active = (view == activeView);
        return IndicatorAtom(active: active);
      }).toList(),
    );
  }
}

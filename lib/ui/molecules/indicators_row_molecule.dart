import 'package:flutter/material.dart';
import 'package:komix/business/models/mixins/view_mixin.dart';
import 'package:komix/ui/atoms/indicatior_atom.dart';

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

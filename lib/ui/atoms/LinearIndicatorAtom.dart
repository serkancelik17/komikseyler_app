import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LinearIndicatorAtom extends StatefulWidget {
  final double percent;
  final double lineHeight;

  LinearIndicatorAtom({this.percent = 0, this.lineHeight = 5});

  @override
  _LinearIndicatorAtomState createState() => _LinearIndicatorAtomState();
}

class _LinearIndicatorAtomState extends State<LinearIndicatorAtom> {
  @override
  Widget build(BuildContext context) {
    return (widget.percent > 0)
        ? LinearPercentIndicator(
            percent: widget.percent,
            lineHeight: widget.lineHeight,
            progressColor: CustomColors.purple,
            fillColor: CustomColors.grey,
            animation: true,
            animationDuration: 500,
          )
        : SizedBox(height: 0);
  }
}

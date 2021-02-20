import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LinearIndicatorAtom extends StatelessWidget {
  final double percent;
  final double lineHeight;

  LinearIndicatorAtom({this.percent = 0, this.lineHeight = 5});

  @override
  Widget build(BuildContext context) {
    return (percent > 0)
        ? LinearPercentIndicator(
            percent: percent,
            lineHeight: lineHeight,
            progressColor: CustomColors.purple,
            fillColor: CustomColors.grey,
          )
        : SizedBox(height: 0);
  }
}

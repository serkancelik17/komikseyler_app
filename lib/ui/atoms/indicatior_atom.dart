import 'package:flutter/material.dart';
import 'package:komix/ui/themes/custom_colors.dart';

class IndicatorAtom extends StatelessWidget {
  final bool active;

  IndicatorAtom({this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? CustomColors.purple : CustomColors.boldGrey),
    );
  }
}

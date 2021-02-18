import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundIconButtonMolecule extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color boxColor;
  final double size;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;

  RoundIconButtonMolecule.large({
    this.icon,
    this.iconColor,
    this.boxColor,
    this.onPressed,
    this.text,
    this.textColor,
  }) : size = 60.0;

  RoundIconButtonMolecule.small({
    this.icon,
    this.iconColor,
    this.boxColor,
    this.onPressed,
    this.text,
    this.textColor,
  }) : size = 50.0;

  RoundIconButtonMolecule({
    this.icon,
    this.iconColor,
    this.boxColor,
    this.size,
    this.onPressed,
    this.text,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: boxColor ?? Colors.white, boxShadow: [
        new BoxShadow(color: const Color(0x11000000), blurRadius: 10.0),
      ]),
      child: new RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 0.0,
        child: Column(
          children: [
            SizedBox(height: 15),
            new Icon(
              icon,
              color: iconColor,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 10, color: textColor ?? Colors.black),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

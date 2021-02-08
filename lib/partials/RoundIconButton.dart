import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;
  final String text;

  RoundIconButton.large({
    this.icon,
    this.iconColor,
    this.onPressed,
    this.text,
  }) : size = 60.0;

  RoundIconButton.small({
    this.icon,
    this.iconColor,
    this.onPressed,
    this.text,
  }) : size = 50.0;

  RoundIconButton({
    this.icon,
    this.iconColor,
    this.size,
    this.onPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
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
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

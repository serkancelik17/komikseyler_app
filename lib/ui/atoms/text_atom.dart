import 'package:flutter/material.dart';

class TextAtom extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  TextAtom({this.text, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}

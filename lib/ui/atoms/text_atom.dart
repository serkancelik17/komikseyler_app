import 'package:flutter/material.dart';

class TextAtom extends StatelessWidget {
  final String text;

  TextAtom(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(this.text);
  }
}

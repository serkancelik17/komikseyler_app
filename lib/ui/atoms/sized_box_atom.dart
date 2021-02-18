import 'package:flutter/material.dart';

class SizedBoxAtom extends StatelessWidget {
  final double width;
  final double height;

  SizedBoxAtom({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}

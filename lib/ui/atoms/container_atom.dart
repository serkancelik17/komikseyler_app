import 'package:flutter/material.dart';

class ContainerAtom extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets margin;
  final Widget child;

  ContainerAtom({this.width, this.height, this.margin, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      margin: this.margin,
      child: this.child,
    );
  }
}

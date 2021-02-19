import 'package:flutter/material.dart';

class ContainerAtom extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets margin;
  final Widget child;
  final Decoration decoration;

  ContainerAtom({this.width, this.height, this.margin, this.child, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      margin: this.margin,
      child: this.child,
      decoration: this.decoration,
    );
  }
}

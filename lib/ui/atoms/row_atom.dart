import 'package:flutter/material.dart';

class RowAtom extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Key key;

  final List<Widget> children;
  RowAtom({this.mainAxisAlignment, this.children, this.crossAxisAlignment, this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}

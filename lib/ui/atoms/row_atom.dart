import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowAtom extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Key key;

  final List<Widget> children;
  RowAtom({this.mainAxisAlignment = MainAxisAlignment.start, this.children, this.crossAxisAlignment = CrossAxisAlignment.start, this.key});

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

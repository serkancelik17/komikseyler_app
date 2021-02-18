import 'package:flutter/material.dart';

class ColumnAtom extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final List<Widget> children;
  final Key key;
  final MainAxisSize mainAxisSize;

  ColumnAtom({this.mainAxisAlignment, this.children, this.key, this.mainAxisSize = MainAxisSize.max});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: children,
      key: key,
      mainAxisSize: mainAxisSize,
    );
  }
}

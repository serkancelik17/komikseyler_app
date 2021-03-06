import 'package:flutter/material.dart';

class ColumnAtom extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final List<Widget> children;
  final Key key;
  final MainAxisSize mainAxisSize;

  ColumnAtom(
      {this.mainAxisAlignment = MainAxisAlignment.start,
      this.children,
      this.key,
      this.mainAxisSize = MainAxisSize.max});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
      key: key,
      mainAxisSize: mainAxisSize,
    );
  }
}

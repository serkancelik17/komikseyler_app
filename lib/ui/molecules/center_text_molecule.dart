import 'package:flutter/material.dart';
import 'package:komix/ui/atoms/center_atom.dart';

class CenterTextMolecule extends StatelessWidget {
  final Widget child;

  CenterTextMolecule({this.child});

  @override
  Widget build(BuildContext context) {
    return CenterAtom(child: child);
  }
}

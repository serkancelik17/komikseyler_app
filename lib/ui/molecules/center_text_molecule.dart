import 'package:flutter/material.dart';
import 'package:komix/ui/atoms/center_atom.dart';

class CenterMolecule extends StatelessWidget {
  final Widget child;

  CenterMolecule(this.child);

  @override
  Widget build(BuildContext context) {
    return CenterAtom(child: child);
  }
}

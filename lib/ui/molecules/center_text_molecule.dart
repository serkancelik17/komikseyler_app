import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/atoms/center_atom.dart';

class CenterMolecule extends StatelessWidget {
  final Widget child;

  CenterMolecule(this.child);

  @override
  Widget build(BuildContext context) {
    return CenterAtom(child: child);
  }
}

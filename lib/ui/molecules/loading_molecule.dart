import 'package:flutter/material.dart';
import 'package:komix/ui/atoms/center_atom.dart';

class LoadingMolecule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CenterAtom(
      child: Image.asset('assets/images/loading.gif', width: 75),
    );
  }
}

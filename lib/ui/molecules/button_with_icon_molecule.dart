import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/atoms/button_atom.dart';

class ButtonWithIconMolecule extends ButtonAtom {
  final Widget child;
  final Widget icon;
  final VoidCallback onTap;

  ButtonWithIconMolecule({this.onTap, this.child, this.icon}) : super(child: child);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            super.build(context),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

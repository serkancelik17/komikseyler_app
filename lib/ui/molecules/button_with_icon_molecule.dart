import 'package:flutter/material.dart';
import 'package:komix/ui/atoms/button_atom.dart';
import 'package:komix/ui/themes/custom_colors.dart';

class ButtonWithIconMolecule extends ButtonAtom {
  final Widget child;
  final Widget icon;
  final VoidCallback onTap;
  final Widget label;

  ButtonWithIconMolecule({this.onTap, this.child, this.icon, this.label}) : super(child: child);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(onPressed: onTap, icon: icon, label: label, style: ElevatedButton.styleFrom(primary: CustomColors.lightPurple));
  }
}

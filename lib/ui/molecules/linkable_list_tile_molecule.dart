import 'package:flutter/material.dart';
import 'package:komix/ui/atoms/inkwell_atom.dart';
import 'package:komix/ui/atoms/list_tile_atom.dart';

class LinkableListTileMolecule extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final VoidCallback onTap;

  LinkableListTileMolecule({this.title, this.leading, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkwellAtom(
      child: ListTileAtom(
        title: title,
        leading: leading,
      ),
      onTap: onTap,
    );
  }
}

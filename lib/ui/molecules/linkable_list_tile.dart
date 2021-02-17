import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/atoms/inkwell_atom.dart';
import 'package:komik_seyler/ui/atoms/list_tile_atom.dart';

class LinkableListTile extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final VoidCallback onTap;

  LinkableListTile({this.title, this.leading, this.onTap});

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

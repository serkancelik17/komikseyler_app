import 'package:flutter/material.dart';

class ListTileAtom extends StatelessWidget {
  final Widget leading;
  final Widget title;

  ListTileAtom({this.leading, this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      trailing: Icon(Icons.arrow_forward_ios_sharp),
      contentPadding: EdgeInsets.all(5),
    );
  }
}

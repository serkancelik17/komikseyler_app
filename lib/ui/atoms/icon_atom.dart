import 'package:flutter/material.dart';

class IconAtom extends StatelessWidget {
  final IconData icon;

  IconAtom({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Icon(icon);
  }
}

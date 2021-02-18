import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FaIconAtom extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  FaIconAtom({@required this.icon, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return FaIcon(icon, color: color, size: size);
  }
}

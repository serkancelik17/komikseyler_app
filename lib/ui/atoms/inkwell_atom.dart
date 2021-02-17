import 'package:flutter/material.dart';

class InkwellAtom extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  InkwellAtom({this.child, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: child,
      onTap: onTap,
    );
  }
}

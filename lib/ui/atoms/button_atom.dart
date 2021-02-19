import 'package:flutter/material.dart';

class ButtonAtom extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  ButtonAtom({@required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(onPressed: onPressed, child: child);
  }
}

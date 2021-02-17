import 'package:flutter/material.dart';

class ButtonAtom extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  ButtonAtom({@required this.child, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}

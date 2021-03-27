import 'package:flutter/material.dart';
import 'package:komix/ui/themes/custom_colors.dart';

class ButtonAtom extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  ButtonAtom({@required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(primary: CustomColors.lightPurple),
    );
  }
}

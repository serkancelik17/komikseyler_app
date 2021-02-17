import 'package:flutter/cupertino.dart';

class CenterAtom extends StatelessWidget {
  final Widget child;

  CenterAtom({this.child});

  @override
  Widget build(BuildContext context) {
    return Center(child: child);
  }
}

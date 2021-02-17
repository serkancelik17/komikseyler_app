import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/atoms/center_atom.dart';
import 'package:komik_seyler/ui/atoms/text_atom.dart';

class CenterText extends StatelessWidget {
  final String text;

  CenterText(this.text);

  @override
  Widget build(BuildContext context) {
    return CenterAtom(child: TextAtom(text));
  }
}

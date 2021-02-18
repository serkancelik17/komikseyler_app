import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/atoms/text_atom.dart';

class TwoColorTextMolecule extends StatelessWidget {
  final String text1;
  final String text2;
  final MainAxisAlignment mainAxisAlignment;

  TwoColorTextMolecule({this.text1, this.text2, this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        TextAtom(text: text1),
        SizedBox(width: 5),
        TextAtom(text: text2),
      ],
    );
  }
}

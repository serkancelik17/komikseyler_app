import 'package:flutter/material.dart';
import 'package:komix/ui/atoms/row_atom.dart';
import 'package:komix/ui/atoms/text_atom.dart';

class TitleColorMolecule extends StatelessWidget {
  final String text;
  final List<Color> colors;
  TitleColorMolecule(
      {this.text, this.colors = const [Colors.black, Colors.white]});

  @override
  Widget build(BuildContext context) {
    List<String> dividedTexts = divideText(text);
    return RowAtom(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < dividedTexts.length; i++)
          TextAtom(text: dividedTexts[i] + " ", color: colors[i % 2]),
      ],
    );
  }

  List<String> divideText(String text) {
    List<String> texts = [];
    texts = text.split(" ");
    return texts;
  }
}

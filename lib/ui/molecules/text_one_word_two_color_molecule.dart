import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/atoms/text_atom.dart';

class TextOneWordTwoColorMolecule extends StatelessWidget {
  final String text;
  final List<Color> colors;
  TextOneWordTwoColorMolecule({this.text, this.colors = const [Colors.black, Colors.white]});

  @override
  Widget build(BuildContext context) {
    List<String> dividedTexts = divideText(text);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < dividedTexts.length; i++) TextAtom(text: dividedTexts[i], color: colors[i]),
      ],
    );
  }

  List<String> divideText(String text) {
    List<String> texts = [];
    if (text.contains(" ")) {
      texts = text.split(" ");
      texts[0] += " ";
    } else {
      int length = text.length;
      int centerLength = (text.length / 2).ceil();
      texts.add(text.substring(0, centerLength));
      texts.add(text.substring(centerLength, length));
    }
    return texts;
  }
}

import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/atoms/text_atom.dart';

class TextTwoWordColorMolecule extends StatelessWidget {
  final List<String> texts;
  final List<Color> colors;
  final MainAxisAlignment mainAxisAlignment;

  TextTwoWordColorMolecule({this.texts, this.colors = const [Colors.black, Colors.black], this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    //@todo atom yapılacak
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        TextAtom(
          text: texts[0],
          color: colors[0],
        ),
        SizedBox(width: 5),
        TextAtom(
          text: texts[1],
          color: colors[1],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/molecules/text_two_word_color_molecule.dart';
import 'package:komik_seyler/ui/templates/home_template.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomeTemplate(
        title: TextTwoWordColorMolecule(texts: ["Komik", "Şeyler"], colors: [Colors.black, CustomColors.purple], mainAxisAlignment: MainAxisAlignment.center),
      ),
    );
  }
}

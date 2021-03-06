import 'package:flutter/material.dart';
import 'package:komix/ui/molecules/title_color_molecule.dart';
import 'package:komix/ui/templates/home_template.dart';
import 'package:komix/ui/themes/custom_colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomeTemplate(
        title: TitleColorMolecule(
            text: "Komix", colors: [Colors.black, CustomColors.purple]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/atoms/sized_box_atom.dart';
import 'package:komik_seyler/ui/atoms/text_atom.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class GridListItemMolecule extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onTap;
  final double fontSize;

  GridListItemMolecule({@required this.icon, @required this.text, this.onTap, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            //border: Border.all(color: Colors.red, width: 5),
            color: CustomColors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColors.darkGrey,
                blurRadius: 5,
                offset: Offset(5, 5), // Shadow position
              ),
              BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                offset: Offset(-5, -5), // Shadow position
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBoxAtom(
              height: 20,
            ),
            TextAtom(
              text: text,
              fontSize: fontSize,
              color: CustomColors.lightPurple,
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

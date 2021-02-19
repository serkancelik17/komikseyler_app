import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komik_seyler/ui/atoms/column_atom.dart';
import 'package:komik_seyler/ui/atoms/fa_icon_atom.dart';
import 'package:komik_seyler/ui/atoms/text_atom.dart';
import 'package:komik_seyler/ui/molecules/rounded_container_molecule.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class RoundedButtonMolecule extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final String text;
  final Color color;
  final bool active;
  final Color activeColor;
  final EdgeInsetsGeometry margin;

  RoundedButtonMolecule({this.iconData, this.onTap, this.text, this.color, activeColor, this.active = false, this.margin}) : activeColor = activeColor ?? CustomColors.purple;

  @override
  Widget build(BuildContext context) {
    return RoundedContainerMolecule(
      margin: EdgeInsets.only(top: 5, right: 20, bottom: 10, left: 20),
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      borderRadius: 5,
      child: InkWell(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            ColumnAtom(
              children: [
                FaIconAtom(
                  icon: iconData ?? FontAwesomeIcons.image,
                  size: 30,
                  color: this.active ? activeColor : this.color ?? CustomColors.boldGrey,
                ),
                TextAtom(
                  text: (this.text ?? "{{icon_text}}"),
                  fontSize: 14,
                  color: this.active ? activeColor : this.color ?? CustomColors.boldGrey,
                ),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

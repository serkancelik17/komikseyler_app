import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komix/ui/atoms/column_atom.dart';
import 'package:komix/ui/atoms/fa_icon_atom.dart';
import 'package:komix/ui/atoms/text_atom.dart';
import 'package:komix/ui/molecules/rounded_container_molecule.dart';
import 'package:komix/ui/themes/custom_colors.dart';

class RoundedButtonMolecule extends StatelessWidget {
  final IconData iconData;
  final IconData activeIconData;
  final VoidCallback onTap;
  final String text;
  final Color color;
  final bool active;
  final Color activeColor;
  final EdgeInsetsGeometry margin;
  final int badgeCount;

  RoundedButtonMolecule(
      {this.iconData = FontAwesomeIcons.image,
      this.onTap,
      this.text,
      this.color,
      activeColor,
      this.active = false,
      this.margin,
      this.activeIconData,
      badgeCount})
      : activeColor = activeColor ?? CustomColors.purple,
        badgeCount = badgeCount ?? 0;

  @override
  Widget build(BuildContext context) {
    return RoundedContainerMolecule(
      margin: EdgeInsets.only(top: 5, right: 20, bottom: 10, left: 20),
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      borderRadius: 10,
      child: InkWell(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            ColumnAtom(
              children: [
                Badge(
                  showBadge: (this.badgeCount > 0),
                  toAnimate: true,
                  position: BadgePosition.topEnd(end: -35, top: -10),
                  badgeColor: CustomColors.purple,
                  badgeContent: Text(
                    badgeCount.toString(),
                    style:
                        TextStyle(fontSize: 10, color: CustomColors.darkGrey),
                  ),
                  child: FaIconAtom(
                    icon: this.active ? activeIconData ?? iconData : iconData,
                    size: 30,
                    color: this.active
                        ? activeColor
                        : this.color ?? CustomColors.boldGrey,
                  ),
                ),
                TextAtom(
                  text: (this.text ?? "{{icon_text}}"),
                  fontSize: 14,
                  color: this.active
                      ? activeColor
                      : this.color ?? CustomColors.boldGrey,
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

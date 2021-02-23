import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/ui/atoms/LinearIndicatorAtom.dart';
import 'package:komik_seyler/ui/atoms/column_atom.dart';
import 'package:komik_seyler/ui/atoms/sized_box_atom.dart';
import 'package:komik_seyler/ui/atoms/text_atom.dart';
import 'package:komik_seyler/ui/molecules/gradient_icon_molecule.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class SectionItemMolecule extends StatelessWidget {
  final SectionMixin section;
  final Color color;

  SectionItemMolecule({@required this.section, color}) : color = color ?? CustomColors.lightPurple;

  @override
  Widget build(BuildContext context) {
    return ColumnAtom(
      children: [
        buildIcon(),
        SizedBoxAtom(
          height: 5,
        ),
        TextAtom(text: section.getTitle(), fontSize: 16, color: color),
        SizedBoxAtom(
          height: 5,
        ),
        LinearIndicatorAtom(percent: section.getPercent()),
      ],
    );
  }

  GradientIconMolecule buildIcon() {
    return GradientIconMolecule(
      icon: section.getIcon(),
      size: 60,
      gradient: LinearGradient(
        colors: [
          CustomColors.purple,
          CustomColors.lightPurple,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}

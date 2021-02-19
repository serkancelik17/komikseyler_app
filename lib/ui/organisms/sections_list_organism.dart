import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/ui/atoms/column_atom.dart';
import 'package:komik_seyler/ui/atoms/sized_box_atom.dart';
import 'package:komik_seyler/ui/atoms/text_atom.dart';
import 'package:komik_seyler/ui/molecules/gradient_icon_molecule.dart';
import 'package:komik_seyler/ui/molecules/rounded_container_molecule.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class SectionListOrganism extends StatelessWidget {
  final List<SectionAbstract> sections;
  final Device device;

  SectionListOrganism({@required this.sections, @required this.device});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.3),
        ),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return RoundedContainerMolecule(
            child: buildWidget(index),
            onTap: () => Navigator.pushNamed(context, '/categories', arguments: [sections[index], device]),
          );
        });
  }

  GradientIconMolecule buildIcon(int index) {
    return GradientIconMolecule(
      icon: sections[index].getIcon(),
      size: 45,
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

  Widget buildWidget(int index) {
    return ColumnAtom(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildIcon(index),
        SizedBoxAtom(
          height: 10,
        ),
        TextAtom(
          text: sections[index].getTitle(),
          fontSize: 16,
          color: CustomColors.lightPurple,
        ),
      ],
    );
  }
}

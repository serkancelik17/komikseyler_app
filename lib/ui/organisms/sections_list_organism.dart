import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/ui/molecules/gradient_icon_molecule.dart';
import 'package:komik_seyler/ui/molecules/grid_list_item_molecule.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class SectionListOrganism extends StatelessWidget {
  final List<SectionAbstract> sections;

  SectionListOrganism({@required this.sections});

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: <Color>[
        CustomColors.purple,
        CustomColors.lightPurple,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.3),
        ),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return GridListItemMolecule(
            fontSize: 16,
            icon: GradientIconMolecule(icon: sections[index].getIcon(), size: 50, gradient: gradient),
            text: sections[index].getTitle(),
            onTap: () => Navigator.pushNamed(context, '/categories', arguments: sections[index]),
          );
        });
  }
}

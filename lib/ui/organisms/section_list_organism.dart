import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/action.dart' as Local;
import 'package:komik_seyler/business/models/category.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/util/settings.dart';
import 'package:komik_seyler/ui/atoms/LinearIndicatorAtom.dart';
import 'package:komik_seyler/ui/atoms/center_atom.dart';
import 'package:komik_seyler/ui/atoms/circular_progress_indicator_atom.dart';
import 'package:komik_seyler/ui/atoms/column_atom.dart';
import 'package:komik_seyler/ui/atoms/sized_box_atom.dart';
import 'package:komik_seyler/ui/atoms/text_atom.dart';
import 'package:komik_seyler/ui/molecules/gradient_icon_molecule.dart';
import 'package:komik_seyler/ui/molecules/rounded_container_molecule.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class SectionListOrganism extends StatefulWidget {
  @override
  _SectionListOrganismState createState() => _SectionListOrganismState();
}

class _SectionListOrganismState extends State<SectionListOrganism> {
  List<SectionMixin> _sections = [];
  Device _device;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSections;
  }

  @override
  Widget build(BuildContext context) {
    return (_sections != null && _sections.length == 0)
        ? CenterAtom(child: CircularProgressIndicatorAtom())
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.3),
            ),
            itemCount: _sections.length,
            itemBuilder: (context, index) {
              return RoundedContainerMolecule(
                child: buildSection(index),
                onTap: () async => await Navigator.pushNamed(context, '/sections', arguments: [_sections[index], _device]).then((section) {
                  setState(() {
                    _sections[index] = section;
                    // refresh state of Page1
                  });
                }),
              );
            });
  }

  GradientIconMolecule buildIcon(int index) {
    return GradientIconMolecule(
      icon: _sections[index].getIcon(),
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

  Widget buildSection(int index) {
    return ColumnAtom(
      children: [
        buildIcon(index),
        SizedBoxAtom(
          height: 5,
        ),
        TextAtom(
          text: _sections[index].getTitle(),
          fontSize: 16,
          color: CustomColors.lightPurple,
        ),
        SizedBoxAtom(
          height: 5,
        ),
        LinearIndicatorAtom(percent: _sections[index].getPercent()),
      ],
    );
  }

  Future<bool> get getSections async {
    //  try {
    List<SectionMixin> categories = (await Category().where(parameters: {'device_uuid': (await Settings.getUuid())})).get().cast<SectionMixin>();
    _sections.addAll(categories);
/*    } catch (error) {
      Navigator.pushNamed(context, '/error', arguments: error);
    }*/

    List<SectionMixin> additionalSections = [
      Local.Action(name: "like", title: "Beğendiklerim", id: 1),
      Local.Action(name: "favorite", title: "Favorilerim", id: 2),
    ];
    _sections.addAll(additionalSections);

    setState(() {});

    return true;
  }
}

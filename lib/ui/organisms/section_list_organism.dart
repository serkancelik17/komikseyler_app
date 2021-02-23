import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/action.dart' as Local;
import 'package:komik_seyler/business/models/category.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/util/settings.dart';
import 'package:komik_seyler/ui/atoms/center_atom.dart';
import 'package:komik_seyler/ui/atoms/circular_progress_indicator_atom.dart';
import 'package:komik_seyler/ui/molecules/rounded_container_molecule.dart';
import 'package:komik_seyler/ui/molecules/section_item_molecule.dart';

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
                child: SectionItemMolecule(section: _sections[index]),
                onTap: () async => await Navigator.pushNamed(context, '/sections', arguments: [_sections[index], _device]).then((section) {
                  setState(() {
                    _sections[index] = section;
                    // refresh state of Page1
                  });
                }),
              );
            });
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

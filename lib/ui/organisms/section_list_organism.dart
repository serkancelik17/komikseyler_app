import 'package:flutter/material.dart';
import 'package:komix/business/models/action.dart' as Local;
import 'package:komix/business/models/category.dart';
import 'package:komix/business/models/device.dart';
import 'package:komix/business/models/mixins/section_mixin.dart';
import 'package:komix/business/util/config/env.dart';
import 'package:komix/business/util/settings.dart';
import 'package:komix/ui/atoms/center_atom.dart';
import 'package:komix/ui/atoms/circular_progress_indicator_atom.dart';
import 'package:komix/ui/molecules/rounded_container_molecule.dart';
import 'package:komix/ui/molecules/section_item_molecule.dart';

class SectionListOrganism extends StatefulWidget {
  @override
  _SectionListOrganismState createState() => _SectionListOrganismState();
}

class _SectionListOrganismState extends State<SectionListOrganism> {
  List<SectionMixin> _sections = [];
  Device _device = Device();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        _device = await Device().find(id: await Settings.getUuid());
        getSections;
      } catch (e, s) {
        print(s.toString());
        Navigator.pushReplacementNamed(context, "/error", arguments: [e]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_sections != null && _sections.length == 0)
        ? CenterAtom(child: CircularProgressIndicatorAtom())
        : Column(
            children: [
              Flexible(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.3),
                    ),
                    itemCount: _sections.length,
                    itemBuilder: (context, index) {
                      return RoundedContainerMolecule(
                        child: SectionItemMolecule(section: _sections[index]),
                        onTap: () async => await Navigator.pushNamed(context, '/sections', arguments: [_sections[index]]).then((section) {
                          _sections[index] = section;
                          setState(() {});
                        }),
                      );
                    }),
              ),
              Text(
                (Env.env != 'prod') ? "Device# " + _device?.uuid ?? '' : "",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          );
  }

  Future<bool> get getSections async {
    List<SectionMixin> categories = (await Category().where(filters: {'device_uuid': await Settings.getUuid()})).get().cast<SectionMixin>();
    _sections.addAll(categories);
    List<SectionMixin> additionalSections = [
      Local.Action(name: "like", title: "Beğendiklerim", id: 1),
      Local.Action(name: "favorite", title: "Favorilerim", id: 2),
      Local.Action(name: "share", title: "Paylaşımlarım", id: 5),
    ];
    _sections.addAll(additionalSections);

    setState(() {});

    return true;
  }
}

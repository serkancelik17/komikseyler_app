import 'package:flutter/material.dart';
import 'package:komix/business/models/action.dart' as Local;
import 'package:komix/business/models/category.dart';
import 'package:komix/business/models/device.dart';
import 'package:komix/business/models/device/option.dart';
import 'package:komix/business/models/mixins/section_mixin.dart';
import 'package:komix/business/util/config/env.dart';
import 'package:komix/business/util/settings.dart';
import 'package:komix/ui/molecules/loading_molecule.dart';
import 'package:komix/ui/molecules/rounded_container_molecule.dart';
import 'package:komix/ui/molecules/section_item_molecule.dart';

class SectionListOrganism extends StatefulWidget {
  @override
  _SectionListOrganismState createState() => _SectionListOrganismState();
}

class _SectionListOrganismState extends State<SectionListOrganism> {
  List<SectionMixin> _sections = [];
  Device _device;
  Option _option;

  @override
  void initState() {
    super.initState();
    getSections;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        _device = await Device().firstOrCreate({'uuid': await Settings.getUuid()});
        _option = await Option(deviceUuid: _device.uuid).firstOrCreate({'device_uuid': await Settings.getUuid()});
      } catch (e, s) {
        print(s.toString());
        Navigator.of(context).pushReplacementNamed("/error", arguments: [e]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_sections != null && _sections.length == 0)
        ? LoadingMolecule()
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
                        onTap: () {
                          return Navigator.pushNamed(context, '/sections', arguments: [_sections[index]]);
                        },
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
    List<SectionMixin> categories = (await Category().setEndPoint('/devices/' + await Settings.getUuid() + '/categories').where()).get().cast<SectionMixin>();
    _sections.addAll(categories);
    List<SectionMixin> additionalSections = [
      Local.Action(name: "like", title: "Beğendiklerim", id: 1),
      Local.Action(name: "favorite", title: "Favorilerim", id: 2),
      Local.Action(name: "share", title: "Paylaşımlarım", id: 5),
    ];

    setState(() {
      _sections.addAll(additionalSections);
    });

    return true;
  }
}

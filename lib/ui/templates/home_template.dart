import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/category.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/ui/atoms/center_atom.dart';
import 'package:komik_seyler/ui/atoms/circular_progress_indicator_atom.dart';
import 'package:komik_seyler/ui/atoms/container_atom.dart';
import 'package:komik_seyler/ui/organisms/app_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/sections_list_organism.dart';

class HomeTemplate extends StatelessWidget {
  final List<SectionAbstract> sections;
  final Device device;
  final Widget title;

  HomeTemplate({@required this.sections, @required this.title, @required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOrganism(
        title: title ?? Text("{title}"),
      ),
      body: ContainerAtom(
        margin: EdgeInsets.all(10),
        child: (sections != null && sections.length == 0)
            ? CenterAtom(child: CircularProgressIndicatorAtom())
            : SectionListOrganism(
                device: device,
                sections: sections ??
                    [
                      Category(id: 1, name: 'ListView 1 Title'),
                    ]),
      ),
    );
  }
}

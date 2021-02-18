import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/category.dart';
import 'package:komik_seyler/ui/atoms/center_atom.dart';
import 'package:komik_seyler/ui/atoms/circular_progress_indicator_atom.dart';
import 'package:komik_seyler/ui/molecules/center_text.dart';
import 'package:komik_seyler/ui/organisms/app_bar_organism.dart';

import 'file:///D:/apps/komik_seyler/lib/ui/organisms/sections_list_view_organism.dart';

class HomeTemplate extends StatefulWidget {
  final List<SectionAbstract> sections;
  final String title;

  HomeTemplate({@required this.sections, this.title});

  @override
  _HomeTemplateState createState() => _HomeTemplateState();
}

class _HomeTemplateState extends State<HomeTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOrganism(
        title: CenterText(widget.title ?? "{title}"),
      ),
      body: (widget.sections != null && widget.sections.length == 0) ? CenterAtom(child: CircularProgressIndicatorAtom()) : HomeListViewOrganism(sections: widget.sections ?? [Category(id: 1, name: 'ListView 1 Title')]),
    );
  }
}

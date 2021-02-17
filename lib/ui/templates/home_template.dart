import 'package:flutter/material.dart';
import 'package:komik_seyler/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/models/category.dart';
import 'package:komik_seyler/ui/molecules/center_text.dart';
import 'package:komik_seyler/ui/organisms/app_bar_organism.dart';

import 'file:///D:/apps/komik_seyler/lib/ui/organisms/sections_list_view_organism.dart';

class HomeTemplate extends StatelessWidget {
  final List<SectionAbstract> sections;
  final String title;

  HomeTemplate({this.sections, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOrganism(
        title: CenterText(title ?? "{title}"),
      ),
      body: HomeListViewOrganism(sections: sections ?? [Category(id: 1, name: 'ListView 1 Title')]),
    );
  }
}

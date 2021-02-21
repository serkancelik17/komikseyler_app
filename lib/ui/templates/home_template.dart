import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/organisms/app_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/section_list_organism.dart';

class HomeTemplate extends StatelessWidget {
  final Widget title;

  HomeTemplate({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOrganism(
        title: title ?? Text("{title}"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SectionListOrganism(/*device: device*/ /*[Category(id: 1, name: 'ListView 1 Title')]*/),
      ),
    );
  }
}

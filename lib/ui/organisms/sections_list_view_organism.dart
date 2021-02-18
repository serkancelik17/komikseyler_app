import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/ui/molecules/linkable_list_tile.dart';

class HomeListViewOrganism extends StatelessWidget {
  final List<SectionAbstract> sections;

  HomeListViewOrganism({@required this.sections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.sections.length,
        itemBuilder: (context, i) {
          {
            return LinkableListTile(
              leading: sections[i].getFaIcon(),
              title: Text(
                sections[i].getTitle(),
              ),
              onTap: () => Navigator.pushNamed(context, '/categories', arguments: sections[i]),
            );
          }
        });
  }
}

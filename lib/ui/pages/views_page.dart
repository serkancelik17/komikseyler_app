import 'package:flutter/material.dart';
import 'package:komik_seyler/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/ui/templates/views_template.dart';

class ViewsPage extends StatelessWidget {
  final SectionAbstract section;

  ViewsPage({@required this.section});

  @override
  Widget build(BuildContext context) {
    return ViewsTemplate(section: section);
  }
}

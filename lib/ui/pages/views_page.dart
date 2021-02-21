import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/sectionable.dart';
import 'package:komik_seyler/ui/templates/views_template.dart';

class ViewsPage extends StatelessWidget {
  final Sectionable section;

  ViewsPage({@required this.section});

  @override
  Widget build(BuildContext context) {
    return ViewsTemplate(section: section);
  }
}

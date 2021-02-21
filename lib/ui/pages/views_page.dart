import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/ui/templates/views_template.dart';

class ViewsPage extends StatelessWidget {
  final SectionMixin section;

  ViewsPage({@required this.section});

  @override
  Widget build(BuildContext context) {
    return ViewsTemplate(section: section);
  }
}

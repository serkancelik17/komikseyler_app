import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/ui/templates/views_template.dart';

class ViewsPage extends StatelessWidget {
  final SectionAbstract section;
  final Device device;

  ViewsPage({@required this.section, @required this.device});

  @override
  Widget build(BuildContext context) {
    return ViewsTemplate(section: section, device: device);
  }
}

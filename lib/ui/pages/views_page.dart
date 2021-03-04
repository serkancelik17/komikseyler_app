import 'package:flutter/material.dart';
import 'package:komix/business/models/mixins/section_mixin.dart';
import 'package:komix/business/models/mixins/view_mixin.dart';
import 'package:komix/ui/templates/views_template.dart';

class ViewsPage extends StatefulWidget {
  final SectionMixin section;
  ViewsPage({@required this.section});

  @override
  _ViewsPageState createState() => _ViewsPageState();
}

class _ViewsPageState extends State<ViewsPage> {
  int pictureChangeCount = 0;
  List<ViewMixin> views;

  @override
  Widget build(BuildContext context) {
    return ViewsTemplate(widget.section);
  }
}

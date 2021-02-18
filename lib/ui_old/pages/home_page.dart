import 'package:flutter/material.dart';
import 'package:komik_seyler/business/util/settings.dart';
import 'package:komik_seyler/ui_old/widgets/categories_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Settings.buildAppBar(),
      body: CategoriesWidget(),
    );
  }
}

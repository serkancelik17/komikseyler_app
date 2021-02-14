import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/util/settings.dart';
import 'package:komik_seyler/widgets/categories_widget.dart';

final mainScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

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

import 'package:flutter/material.dart';
import 'package:komik_seyler/models/category.dart';
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/partials/bottomBar.dart';
import 'package:komik_seyler/repositories/category_repository.dart';

import './cards.dart';
import './matches.dart';

/*final MatchEngine matchEngine = new MatchEngine(
    matches: demoPictures.map((Picture picture) {
  return Match(picture: picture);
}).toList());*/

class CategoryPictures extends StatefulWidget {
  final Category category;
  MatchEngine matchEngine;

  CategoryPictures({
    this.category,
    Key key,
  }) : super(key: key) {
    matchEngine = new MatchEngine();
  }

  @override
  CategoryPicturesState createState() => CategoryPicturesState();
}

class CategoryPicturesState extends State<CategoryPictures> {
  CategoryRepository _categoryRepository = CategoryRepository();
  final pageTextFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("----tazelendim----");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: (widget.matchEngine.matches.length == 0) ? Center(child: Text("Yükleniyor...")) : new CardStack(parent: this, matchEngine: widget.matchEngine, categoryId: widget.category.id),
      bottomNavigationBar: (widget.matchEngine.matches.length != 0) ? BottomBar(context: context, currentMatch: widget.matchEngine.currentMatch) : null,
    );
  }

  Future<void> getInit() async {
    List<Picture> _pictures = await _categoryRepository.pictures(categoryId: widget.category.id, page: 1);
    setState(() {
      widget.matchEngine.matches.addAll(_pictures.map((Picture picture) => Match(picture: picture)));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:komik_seyler/main.dart';
import 'package:komik_seyler/models/categories.dart';
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/repositories/category_repository.dart';

import './cards.dart';
import './matches.dart';
import 'models/response.dart';

/*final MatchEngine matchEngine = new MatchEngine(
    matches: demoPictures.map((Picture picture) {
  return Match(picture: picture);
}).toList());*/

class CategoryPictures extends StatefulWidget {
  final Category category;
  MatchEngine matchEngine;

  CategoryPictures({
    @required this.category,
    Key key,
  }) : super(key: key) {
    matchEngine = new MatchEngine();
  }

  @override
  _CategoryPicturesState createState() => _CategoryPicturesState();
}

class _CategoryPicturesState extends State<CategoryPictures> {
  Match match = new Match();
  CategoryRepository _categoryRepository = CategoryRepository();
  final pageTextFieldController = TextEditingController();

  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new RoundIconButton.large(
                icon: Icons.clear,
                iconColor: Colors.red,
                text: "Sil",
                onPressed: () {
                  try {
                    widget.matchEngine.currentMatch.destroy().then((value) {
                      if (value == true) {
                        SnackBar _snackBar = SnackBar(content: Text('Silindi'), backgroundColor: Colors.green);
                        mainScaffoldMessengerKey.currentState.showSnackBar(_snackBar);
                      } else {
                        SnackBar _snackBar = SnackBar(content: Text('Destroy Problem!'), backgroundColor: Colors.red);
                        mainScaffoldMessengerKey.currentState.showSnackBar(_snackBar);
                      }
                    });
                  } catch (e) {
                    throw e;
                  }
                },
              ),
              new RoundIconButton.large(
                icon: Icons.compare_arrows,
                iconColor: Colors.blue,
                text: "Taşı",
                onPressed: () {
                  try {
                    widget.matchEngine.currentMatch.addAction(actionName: 'move', value: true).then((Response response) {
                      print("move;" + response.success.toString());
                      if (response.success == true) {
                        _showSnackbar("Taşıma İşaretlendi", Colors.green);
                      } else {
                        _showSnackbar(response.message, Colors.red);
                      }
                    });
                  } catch (e) {
                    throw e;
                  }
                },
              ),
              new RoundIconButton.large(
                icon: Icons.favorite,
                iconColor: Colors.green,
                text: "Beğen",
                onPressed: () {
                  try {
                    widget.matchEngine.currentMatch.addAction(actionName: 'like', value: true).then((Response response) {
                      print("like;" + response.success.toString());
                      if (response.success == true) {
                        _showSnackbar("Beğendiniz", Colors.green);
                      } else {
                        _showSnackbar(response.message, Colors.red);
                      }
                    });
                  } catch (e) {
                    throw e;
                  }
                },
              ),
              new RoundIconButton.large(
                icon: Icons.star,
                iconColor: Colors.blue,
                text: "Favori",
                onPressed: () {
                  try {
                    widget.matchEngine.currentMatch.addAction(actionName: 'favorite', value: true).then((Response response) {
                      print("favorite;" + response.success.toString());
                      if (response.success == true) {
                        _showSnackbar("Favorilere Eklediniz", Colors.green);
                      } else {
                        _showSnackbar(response.message, Colors.red);
                      }
                    });
                  } catch (e) {
                    throw e;
                  }
                },
              ),
            ],
          ),
        ));
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: (widget.matchEngine.matches.length == 0) ? Center(child: Text("Yükleniyor...")) : new CardStack(matchEngine: widget.matchEngine, categoryId: widget.category.id),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  _showSnackbar(String text, Color backgroundColor) {
    SnackBar _snackBar = SnackBar(
      content: Text(text),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 1),
    );
    mainScaffoldMessengerKey.currentState.showSnackBar(_snackBar);
  }

  Future<void> getInit() async {
    List<Picture> _pictures = await _categoryRepository.pictures(categoryId: widget.category.id, page: 1);
    setState(() {
      widget.matchEngine.matches.addAll(_pictures.map((Picture picture) => Match(picture: picture)));
    });
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;
  final String text;

  RoundIconButton.large({
    this.icon,
    this.iconColor,
    this.onPressed,
    this.text,
  }) : size = 60.0;

  RoundIconButton.small({
    this.icon,
    this.iconColor,
    this.onPressed,
    this.text,
  }) : size = 50.0;

  RoundIconButton({
    this.icon,
    this.iconColor,
    this.size,
    this.onPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
        new BoxShadow(color: const Color(0x11000000), blurRadius: 10.0),
      ]),
      child: new RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 0.0,
        child: Column(
          children: [
            SizedBox(height: 15),
            new Icon(
              icon,
              color: iconColor,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

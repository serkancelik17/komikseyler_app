import 'package:flutter/material.dart';
import 'package:komik_seyler/main.dart';
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/repositories/category_repository.dart';

import './cards.dart';
import './matches.dart';

/*final MatchEngine matchEngine = new MatchEngine(
    matches: demoPictures.map((Picture picture) {
  return Match(picture: picture);
}).toList());*/

MatchEngine matchEngine = new MatchEngine();

class CategoryPictures extends StatefulWidget {
  final int categoryId;
  CategoryPictures({
    @required this.categoryId,
    Key key,
  }) : super(key: key) {
    matchEngine.matches = [];
  }

  @override
  _CategoryPicturesState createState() => _CategoryPicturesState();
}

class _CategoryPicturesState extends State<CategoryPictures> {
  Match match = new Match();
  CategoryRepository _categoryRepository = CategoryRepository();
  CardStack _cardStack;
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
                onPressed: () {
                  try {
                    matchEngine.currentMatch.destroy().then((value) {
                      if (value == true) {
                        SnackBar _snackBar = SnackBar(content: Text('Destroyed'), backgroundColor: Colors.green);
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
                onPressed: () {
                  try {
                    matchEngine.currentMatch.addAction(actionName: 'move', value: true).then((value) {
                      print("move;" + value.toString());
                      if (value == true) {
                        _showSnackbar("Moved", Colors.green);
                      } else {
                        _showSnackbar("Moved Problem", Colors.red);
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
                onPressed: () {
                  try {
                    matchEngine.currentMatch.like(value: true).then((value) {
                      print("like;" + value.toString());
                      if (value == true) {
                        _showSnackbar("Liked", Colors.green);
                      } else {
                        _showSnackbar("Liked Problem!", Colors.red);
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
                onPressed: () {
                  try {
                    matchEngine.currentMatch.addAction(actionName: 'favorite', value: true).then((value) {
                      print("favorite;" + value.toString());
                      if (value == true) {
                        _showSnackbar("Favorited", Colors.green);
                      } else {
                        _showSnackbar("Favorited Problem", Colors.red);
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
    _cardStack = new CardStack(matchEngine: matchEngine, categoryId: widget.categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Komik Şeyler"),
      ),
      body: (matchEngine.matches.length == 0) ? Center(child: Text("Yükleniyor...")) : _cardStack,
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
    List<Picture> _pictures = await _categoryRepository.pictures(categoryId: widget.categoryId, page: 1);
    setState(() {
      matchEngine.matches.addAll(_pictures.map((Picture picture) => Match(picture: picture)));
    });
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;

  RoundIconButton.large({
    this.icon,
    this.iconColor,
    this.onPressed,
  }) : size = 60.0;

  RoundIconButton.small({
    this.icon,
    this.iconColor,
    this.onPressed,
  }) : size = 50.0;

  RoundIconButton({
    this.icon,
    this.iconColor,
    this.size,
    this.onPressed,
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
        child: new Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

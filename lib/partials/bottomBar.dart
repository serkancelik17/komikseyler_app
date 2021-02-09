import 'package:flutter/material.dart';
import 'package:komik_seyler/matches.dart';
import 'package:komik_seyler/models/response.dart';
import 'package:komik_seyler/partials/RoundIconButton.dart';
import 'package:komik_seyler/util/helpers.dart';

class BottomBar extends StatefulWidget {
  final Match currentMatch;
  final BuildContext context;
  BottomBar({@required this.context, @required this.currentMatch});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    print(widget.currentMatch.picture.toString());
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
                    widget.currentMatch.destroy().then((value) {
                      if (value == true) {
                        Helpers.showSnackBar(context: context, text: "Silindi", backgroundColor: Colors.green);
                      } else {
                        Helpers.showSnackBar(context: context, text: 'Destroy Problem!', backgroundColor: Colors.red);
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
                text: "Taşı ",
                onPressed: () {
                  try {
                    widget.currentMatch.addAction(actionName: 'move', value: true).then((Response response) {
                      print("move;" + response.success.toString());
                      if (response.success == true) {
                        Helpers.showSnackBar(context: context, text: "Taşıma İşaretlendi", backgroundColor: Colors.green);
                      } else {
                        Helpers.showSnackBar(context: context, text: response.message, backgroundColor: Colors.red);
                      }
                    });
                  } catch (e) {
                    throw e;
                  }
                },
              ),
              new RoundIconButton.large(
                icon: Icons.favorite,
                boxColor: ((widget.currentMatch != null && widget.currentMatch.picture.userLikesCount > 0) ? Colors.green : Colors.white),
                iconColor: ((widget.currentMatch != null && widget.currentMatch.picture.userLikesCount > 0) ? Colors.white : Colors.green),
                textColor: ((widget.currentMatch != null && widget.currentMatch.picture.userLikesCount > 0) ? Colors.white : Colors.green),
                text: "Beğen(" + (((widget.currentMatch != null) ? widget.currentMatch.picture.likesCount ?? 0 : 0)).toString() + ")",
                onPressed: () {
                  try {
                    widget.currentMatch.addAction(actionName: 'like', value: true).then((Response response) {
                      print("like;" + response.success.toString());
                      if (response.success == true) {
                        Helpers.showSnackBar(context: context, text: "Beğendiniz", backgroundColor: Colors.green);
                      } else {
                        Helpers.showSnackBar(context: context, text: response.message, backgroundColor: Colors.red);
                      }
                    });
                  } catch (e) {
                    throw e;
                  }
                },
              ),
              new RoundIconButton.large(
                icon: Icons.star,
                boxColor: ((widget.currentMatch != null && widget.currentMatch.picture.userFavoritesCount > 0) ? Colors.blue : Colors.white),
                iconColor: ((widget.currentMatch != null && widget.currentMatch.picture.userFavoritesCount > 0) ? Colors.white : Colors.blue),
                textColor: ((widget.currentMatch != null && widget.currentMatch.picture.userFavoritesCount > 0) ? Colors.white : Colors.blue),
                text: "Favori(" + (((widget.currentMatch != null) ? widget.currentMatch.picture.favoritesCount ?? 0 : 0)).toString() + ")",
                onPressed: () {
                  try {
                    widget.currentMatch.addAction(actionName: 'favorite', value: true).then((Response response) {
                      print("favorite;" + response.success.toString());
                      if (response.success == true) {
                        setState(() {
                          widget.currentMatch.picture.userFavoritesCount += 1;
                        });
                        Helpers.showSnackBar(context: context, text: "Favorilere Eklendi", backgroundColor: Colors.green);
                      } else {
                        widget.currentMatch.picture.userFavoritesCount -= 1;
                        Helpers.showSnackBar(context: context, text: response.message, backgroundColor: Colors.red);
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
}

import 'package:flutter/material.dart';
import 'package:komik_seyler/matches.dart';
import 'package:komik_seyler/models/response.dart';
import 'package:komik_seyler/partials/RoundIconButton.dart';
import 'package:komik_seyler/partials/snackBar.dart';

import '../main.dart';

class BottomBar extends StatefulWidget {
  final MatchEngine matchEngine;
  final BuildContext context;
  BottomBar({@required this.context, @required this.matchEngine});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
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
                text: "Taşı ",
                onPressed: () {
                  try {
                    widget.matchEngine.currentMatch.addAction(actionName: 'move', value: true).then((Response response) {
                      print("move;" + response.success.toString());
                      if (response.success == true) {
                        ShowSnackBar("Taşıma İşaretlendi", Colors.green);
                      } else {
                        ShowSnackBar(response.message, Colors.red);
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
                        ShowSnackBar("Beğendiniz", Colors.green);
                      } else {
                        ShowSnackBar(response.message, Colors.red);
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
                        ShowSnackBar("Favorilere Eklediniz", Colors.green);
                      } else {
                        ShowSnackBar(response.message, Colors.red);
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

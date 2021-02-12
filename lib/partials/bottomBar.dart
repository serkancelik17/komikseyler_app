import 'package:flutter/material.dart';
import 'package:komik_seyler/matches.dart';
import 'package:komik_seyler/models/response.dart';
import 'package:komik_seyler/partials/RoundIconButton.dart';
import 'package:komik_seyler/util/helpers.dart';
import 'package:komik_seyler/util/settings.dart';

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
                  toggleAction('like');
                },
              ),
              new RoundIconButton.large(
                icon: Icons.star,
                boxColor: ((widget.currentMatch != null && widget.currentMatch.picture.userFavoritesCount > 0) ? Colors.blue : Colors.white),
                iconColor: ((widget.currentMatch != null && widget.currentMatch.picture.userFavoritesCount > 0) ? Colors.white : Colors.blue),
                textColor: ((widget.currentMatch != null && widget.currentMatch.picture.userFavoritesCount > 0) ? Colors.white : Colors.blue),
                text: "Favori(" + (((widget.currentMatch != null) ? widget.currentMatch.picture.favoritesCount ?? 0 : 0)).toString() + ")",
                onPressed: () {
                  toggleAction('favorite');
                },
              ),
              new RoundIconButton.large(
                icon: Icons.share,
                iconColor: Colors.blue,
                text: "Paylaş",
                onPressed: () {
                  try {
                    Settings.share(widget.currentMatch.picture.path);
                  } catch (e) {
                    print("(Paylaşılırken bir hat oluştu. Resim paylaşılamadı.)");
                  }
/*
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
*/
                },
              ),
            ],
          ),
        ));
  }

  bool toggleAction(String actionName) {
    bool willAdd;
    setState(() {
      if (actionName == 'like') {
        willAdd = (widget.currentMatch.picture.userLikesCount == 0) ? true : false; //eklenecek - silinecek
        widget.currentMatch.picture.userLikesCount = (willAdd) ? 1 : 0;
        widget.currentMatch.picture.likesCount += (willAdd) ? 1 : -1;
      } else if (actionName == 'favorite') {
        willAdd = (widget.currentMatch.picture.userFavoritesCount == 0) ? true : false; //eklenecek - silinecek
        widget.currentMatch.picture.userFavoritesCount = (willAdd) ? 1 : 0;
        widget.currentMatch.picture.favoritesCount += (willAdd) ? 1 : -1;
      }
    });
    widget.currentMatch.addAction(actionName: actionName, value: willAdd).then((Response response) {
      print("response.success;" + response.success.toString() + ";value:" + willAdd.toString());
    });
    return true;
  }
}

import 'package:flutter/material.dart';
import 'package:komik_seyler/models/action.dart' as Local;
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/models/response.dart';
import 'package:komik_seyler/partials/RoundIconButton.dart';
import 'package:komik_seyler/repositories/picture_repository.dart';
import 'package:komik_seyler/util/helpers.dart';
import 'package:komik_seyler/util/settings.dart';

class BottomBar extends StatefulWidget {
  final Picture currentPicture;
  final BuildContext context;
  BottomBar({@required this.context, @required this.currentPicture});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  PictureRepository _pictureRepository = PictureRepository();

  @override
  Widget build(BuildContext context) {
    print("Bottombar picture : " + widget.currentPicture.toString());
    print(widget.currentPicture.toString());
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
                    _pictureRepository.destroy(pictureId: widget.currentPicture.id).then((value) {
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
                    _pictureRepository.addAction(action: new Local.Action(name: 'move'), value: true, picture: widget.currentPicture).then((Response response) {
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
                boxColor: ((widget.currentPicture != null && widget.currentPicture.userLikesCount > 0) ? Colors.green : Colors.white),
                iconColor: ((widget.currentPicture != null && widget.currentPicture.userLikesCount > 0) ? Colors.white : Colors.green),
                textColor: ((widget.currentPicture != null && widget.currentPicture.userLikesCount > 0) ? Colors.white : Colors.green),
                text: "Beğen(" + (((widget.currentPicture != null) ? widget.currentPicture.likesCount ?? 0 : 0)).toString() + ")",
                onPressed: () {
                  toggleAction('like');
                },
              ),
              new RoundIconButton.large(
                icon: Icons.star,
                boxColor: ((widget.currentPicture != null && widget.currentPicture.userFavoritesCount > 0) ? Colors.blue : Colors.white),
                iconColor: ((widget.currentPicture != null && widget.currentPicture.userFavoritesCount > 0) ? Colors.white : Colors.blue),
                textColor: ((widget.currentPicture != null && widget.currentPicture.userFavoritesCount > 0) ? Colors.white : Colors.blue),
                text: "Favori(" + (((widget.currentPicture != null) ? widget.currentPicture.favoritesCount ?? 0 : 0)).toString() + ")",
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
                    Settings.share(widget.currentPicture.path);
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
        willAdd = (widget.currentPicture.userLikesCount == 0) ? true : false; //eklenecek - silinecek
        widget.currentPicture.userLikesCount = (willAdd) ? 1 : 0;
        widget.currentPicture.likesCount += (willAdd) ? 1 : -1;
      } else if (actionName == 'favorite') {
        willAdd = (widget.currentPicture.userFavoritesCount == 0) ? true : false; //eklenecek - silinecek
        widget.currentPicture.userFavoritesCount = (willAdd) ? 1 : 0;
        widget.currentPicture.favoritesCount += (willAdd) ? 1 : -1;
      }
    });
    _pictureRepository.addAction(action: new Local.Action(name: 'hit'), value: willAdd, picture: widget.currentPicture).then((Response response) {
      print("response.success;" + response.success.toString() + ";value:" + willAdd.toString());
    });
    return true;
  }
}

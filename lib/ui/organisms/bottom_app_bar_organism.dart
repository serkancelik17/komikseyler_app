import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/action.dart' as Local;
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/repositories/picture_repository.dart';
import 'package:komik_seyler/business/util/settings.dart';
import 'package:komik_seyler/ui_old/partials/RoundIconButton.dart';

class BottomAppBarOrganism extends StatefulWidget {
  final Picture activeView;
  final BuildContext context;

  BottomAppBarOrganism({@required this.context, @required this.activeView});

  @override
  _BottomAppBarOrganismState createState() => _BottomAppBarOrganismState();
}

class _BottomAppBarOrganismState extends State<BottomAppBarOrganism> {
  PictureRepository _pictureRepository = PictureRepository();
  Device _device = new Device();
  Color destroyBoxColor = Colors.white;
  Color moveBoxColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (_device.isAdmin == 1)
            new RoundIconButton.large(
              boxColor: destroyBoxColor,
              icon: Icons.clear,
              iconColor: Colors.red,
              text: "Sil",
              onPressed: () {
                try {
                  _pictureRepository.destroy(pictureId: widget.activeView.id).then((Response response) {
                    print("destroy;" + response.success.toString());
                    setState(() {
                      destroyBoxColor = (destroyBoxColor == Colors.white) ? Colors.red : Colors.white;
                    });
                  });
                } catch (e) {
                  throw e;
                }
              },
            ),
          if (_device.isAdmin == 1)
            new RoundIconButton.large(
              boxColor: moveBoxColor,
              icon: Icons.compare_arrows,
              iconColor: Colors.blue,
              text: "Taşı ",
              onPressed: () {
                try {
                  _pictureRepository.addAction(action: new Local.Action(id: 4, name: 'move'), value: true, picture: widget.activeView).then((Response response) {
                    print("move;" + response.success.toString());
                    setState(() {
                      moveBoxColor = (moveBoxColor == Colors.white) ? Colors.blue : Colors.white;
                    });
                  });
                } catch (e) {
                  throw e;
                }
              },
            ),
          new RoundIconButton.large(
            icon: Icons.favorite,
            boxColor: ((widget.activeView != null && widget.activeView.userLikesCount > 0) ? Colors.green : Colors.white),
            iconColor: ((widget.activeView != null && widget.activeView.userLikesCount > 0) ? Colors.white : Colors.green),
            textColor: ((widget.activeView != null && widget.activeView.userLikesCount > 0) ? Colors.white : Colors.green),
            text: "Beğen(" + (((widget.activeView != null) ? widget.activeView.likesCount ?? 0 : 0)).toString() + ")",
            onPressed: () {
              toggleAction(Local.Action(id: 1, name: 'like'));
            },
          ),
          new RoundIconButton.large(
            icon: Icons.star,
            boxColor: ((widget.activeView != null && widget.activeView.userFavoritesCount > 0) ? Colors.blue : Colors.white),
            iconColor: ((widget.activeView != null && widget.activeView.userFavoritesCount > 0) ? Colors.white : Colors.blue),
            textColor: ((widget.activeView != null && widget.activeView.userFavoritesCount > 0) ? Colors.white : Colors.blue),
            text: "Favori(" + (((widget.activeView != null) ? widget.activeView.favoritesCount ?? 0 : 0)).toString() + ")",
            onPressed: () {
              toggleAction(Local.Action(id: 2, name: 'favorite'));
            },
          ),
          new RoundIconButton.large(
            icon: Icons.share,
            iconColor: Colors.blue,
            text: "Paylaş",
            onPressed: () {
              try {
                Settings.share(widget.activeView.path);
              } catch (e) {
                print("(Paylaşılırken bir hat oluştu. Resim paylaşılamadı.)");
              }
            },
          ),
        ],
      ),
    );
  }

  bool toggleAction(Local.Action action) {
    bool willAdd;
    setState(() {
      if (action.name == 'like') {
        willAdd = (widget.activeView.userLikesCount == 0) ? true : false; //eklenecek - silinecek
        widget.activeView.userLikesCount = (willAdd) ? 1 : 0;
        widget.activeView.likesCount += (willAdd) ? 1 : -1;
      } else if (action.name == 'favorite') {
        willAdd = (widget.activeView.userFavoritesCount == 0) ? true : false; //eklenecek - silinecek
        widget.activeView.userFavoritesCount = (willAdd) ? 1 : 0;
        widget.activeView.favoritesCount += (willAdd) ? 1 : -1;
      }
    });
    _pictureRepository.addAction(action: action, value: willAdd, picture: widget.activeView).then((Response response) {
      print("response.success;" + response.success.toString() + ";value:" + willAdd.toString());
    });
    return true;
  }
}

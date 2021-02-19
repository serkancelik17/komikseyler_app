import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komik_seyler/business/models/action.dart' as Local;
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/repositories/picture_repository.dart';
import 'package:komik_seyler/ui/molecules/rounded_button_molecule.dart';

class BottomNavigationBarOrganism extends StatefulWidget {
  final Picture activeView;
  final BuildContext context;

  BottomNavigationBarOrganism({@required this.context, @required this.activeView});

  @override
  _BottomNavigationBarOrganismState createState() => _BottomNavigationBarOrganismState();
}

class _BottomNavigationBarOrganismState extends State<BottomNavigationBarOrganism> {
  PictureRepository _pictureRepository = PictureRepository();
  Device _device;
  Color destroyBoxColor = Colors.white;
  Color moveBoxColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BottomAppBar(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (_device?.option?.isAdmin == 1)
              RoundedButtonMolecule(
                iconData: FontAwesomeIcons.trashAlt,
                onTap: destroy(widget.activeView),
                text: "Sil",
              ),
            if (_device?.option?.isAdmin == 1)
              RoundedButtonMolecule(
                iconData: FontAwesomeIcons.exchangeAlt,
                onTap: () {
                  addAction(action: Local.Action(id: 4, name: 'move'), picture: widget.activeView);
                },
                text: "Taşı",
              ),
            RoundedButtonMolecule(
              iconData: FontAwesomeIcons.heart,
              onTap: () {
                addAction(action: Local.Action(id: 1, name: 'like'), picture: widget.activeView);
              },
              active: (widget.activeView.userLikesCount > 0),
              text: "Beğen",
            ),
            RoundedButtonMolecule(
              iconData: FontAwesomeIcons.star,
              onTap: () {
                addAction(action: Local.Action(id: 2, name: 'favorite'), picture: widget.activeView);
              },
              text: "Favori",
              active: (widget.activeView.userFavoritesCount > 0),
            ),
            RoundedButtonMolecule(
              iconData: FontAwesomeIcons.shareAlt,
              onTap: () {
                addAction(action: Local.Action(id: 5, name: 'share'), picture: widget.activeView);
              },
              text: "Paylaş",
            ),
            /*
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
            ),*/
          ],
        ),
      ),
    );
  }

  addAction({Picture picture, Local.Action action}) {
    try {
      _pictureRepository.addAction(action: action, value: true, picture: picture).then((Response response) {
        print(action.name + ";" + response.success.toString());
        /*      setState(() {
          //@todo
          //moveBoxColor = (moveBoxColor == Colors.white) ? Colors.blue : Colors.white;
        });*/
      });
    } catch (e) {
      throw e;
    }
  }

  destroy(Picture picture) {
    try {
      _pictureRepository.destroy(pictureId: picture.id).then((Response response) {
        print("destroy;" + response.success.toString());
        /*   setState(() {
          //@todo
          //destroyBoxColor = (destroyBoxColor == Colors.white) ? Colors.red : Colors.white;
        });*/
      });
    } catch (e) {
      throw e;
    }
  }

  bool toggleAction(Local.Action action) {
    bool willAdd;
/*    setState(() {
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
    });*/
    return true;
  }
}

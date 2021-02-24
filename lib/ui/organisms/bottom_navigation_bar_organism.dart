import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komik_seyler/business/models/action.dart' as Local;
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/models/picture/action.dart';
import 'package:komik_seyler/business/util/settings.dart';
import 'package:komik_seyler/ui/molecules/rounded_button_molecule.dart';

class BottomNavigationBarOrganism extends StatefulWidget {
  final Picture activeView;
  final BuildContext context;

  BottomNavigationBarOrganism({@required this.context, @required this.activeView});

  @override
  _BottomNavigationBarOrganismState createState() => _BottomNavigationBarOrganismState();
}

class _BottomNavigationBarOrganismState extends State<BottomNavigationBarOrganism> {
  Device _device;
  Color destroyBoxColor = Colors.white;
  Color moveBoxColor = Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _device = await Device().find(id: await Settings.getUuid());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BottomAppBar(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (_device?.option?.isAdmin == 1)
              RoundedButtonMolecule(
                iconData: FontAwesomeIcons.trashAlt,
                onTap: () => destroy(widget.activeView),
                text: "Sil",
              ),
            if (_device?.option?.isAdmin == 1)
              RoundedButtonMolecule(
                iconData: FontAwesomeIcons.exchangeAlt,
                onTap: () {
                  toggleAction(action: Local.Action(id: 4, name: 'move'));
                },
                text: "Taşı",
              ),
            RoundedButtonMolecule(
              badgeCount: widget.activeView.likesCount,
              iconData: FontAwesomeIcons.heart,
              activeIconData: FontAwesomeIcons.solidHeart,
/*              activeColor: CustomColors.lightRed,*/
              onTap: () {
                toggleAction(action: Local.Action(id: 1, name: 'like'));
              },
              active: (widget.activeView.userLikesCount != 0),
              text: "Beğen",
            ),
            RoundedButtonMolecule(
              badgeCount: widget.activeView.favoritesCount,
              iconData: FontAwesomeIcons.star,
              activeIconData: FontAwesomeIcons.solidStar,
/*              activeColor: CustomColors.lightYellow,*/
              onTap: () {
                toggleAction(action: Local.Action(id: 2, name: 'favorite'));
              },
              text: "Favori",
              active: (widget.activeView.userFavoritesCount != 0),
            ),
            RoundedButtonMolecule(
              badgeCount: widget.activeView.sharesCount,
              active: (widget.activeView.userSharesCount != 0),
              iconData: FontAwesomeIcons.share,
/*              activeColor: CustomColors.lightBlue,*/
              onTap: () {
                toggleAction(action: Local.Action(id: 5, name: 'share'));
              },
              text: "Paylaş",
            ),
          ],
        ),
      ),
    );
  }

  addAction({Picture picture, Local.Action action}) {
    try {
      action.store();
      // _pictureRepository.addAction(action: action, value: true, picture: picture).then((Response response) {
      //       print(action.name + ";" + response.success.toString());
      /*      setState(() {
          //@todo
          //moveBoxColor = (moveBoxColor == Colors.white) ? Colors.blue : Colors.white;
        });*/
      /*    });*/
    } catch (e) {
      toggleAction(action: action);
      throw e;
    }
  }

  destroy(Picture picture) {
    try {
      picture.destroy();
      //_pictureRepository.destroy(pictureId: picture.id).then((Response response) {
      // print("destroy;" + response.success.toString());
      /*   setState(() {
          //@todo
          //destroyBoxColor = (destroyBoxColor == Colors.white) ? Colors.red : Colors.white;
        });*/
      /*});*/
    } catch (e) {
      throw e;
    }
  }

  bool toggleAction({@required Local.Action action}) {
    bool willAdd;
    if (action.name == 'like') {
      willAdd = (widget.activeView.userLikesCount == 0) ? true : false; //eklenecek - silinecek
      widget.activeView.userLikesCount = (willAdd) ? 1 : 0;
      widget.activeView.likesCount += (willAdd) ? 1 : -1;
    } else if (action.name == 'favorite') {
      willAdd = (widget.activeView.userFavoritesCount == 0) ? true : false; //eklenecek - silinecek
      widget.activeView.userFavoritesCount = (willAdd) ? 1 : 0;
      widget.activeView.favoritesCount += (willAdd) ? 1 : -1;
    } else if (action.name == 'share') {
      Settings.share(picture: widget.activeView).then((value) {
        setState(() {
          widget.activeView.userSharesCount = 1;
          widget.activeView.sharesCount += 1;
        });
      });
      willAdd = true; //eklenecek - silinecek

    }
    PictureAction _pa = PictureAction(pictureId: widget.activeView.id, actionId: action.id, deviceUuid: _device.uuid);
    if (willAdd)
      _pa.store();
    else
      _pa.destroy();

    setState(() {});

/*    _pictureRepository.addAction(action: action, value: willAdd, picture: widget.activeView).then((Response response) {
      print("response.success;" + response.success.toString() + ";value:" + willAdd.toString());
    });*/
    return true;
  }
}

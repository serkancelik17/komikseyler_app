import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komix/business/models/action.dart' as Local;
import 'package:komix/business/models/device.dart';
import 'package:komix/business/models/picture.dart';
import 'package:komix/business/models/picture/action.dart';
import 'package:komix/business/util/settings.dart';
import 'package:komix/ui/molecules/rounded_button_molecule.dart';
import 'package:komix/ui/themes/custom_colors.dart';

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
            RoundedButtonMolecule(
              badgeCount: widget.activeView.likeCount,
              iconData: FontAwesomeIcons.heart,
              activeIconData: FontAwesomeIcons.solidHeart,
              activeColor: CustomColors.lightRed,
              onTap: () {
                toggleAction(action: Local.Action(id: 1, name: 'like'));
              },
              active: (widget.activeView.findPictureAction(1) != null),
              text: "Beğen",
            ),
            RoundedButtonMolecule(
              badgeCount: widget.activeView.favoriteCount,
              iconData: FontAwesomeIcons.star,
              activeIconData: FontAwesomeIcons.solidStar,
              activeColor: CustomColors.lightYellow,
              onTap: () {
                toggleAction(action: Local.Action(id: 2, name: 'favorite'));
              },
              text: "Favori",
              active: (widget.activeView.findPictureAction(2) != null),
            ),
            RoundedButtonMolecule(
              badgeCount: widget.activeView.shareCount,
              active: (widget.activeView.findPictureAction(5) != null),
              iconData: FontAwesomeIcons.share,
              activeColor: CustomColors.lightBlue,
              onTap: () {
                share();
              },
              text: "Paylaş",
            ),
            if (_device?.option?.isAdmin == 1)
              RoundedButtonMolecule(
                iconData: FontAwesomeIcons.trashAlt,
                onTap: () => destroy(),
                text: "Sil",
              ),
            if (_device?.option?.isAdmin == 1)
              RoundedButtonMolecule(
                iconData: FontAwesomeIcons.exchangeAlt,
                onTap: () => move(),
                text: "Taşı",
              ),
          ],
        ),
      ),
    );
  }

  destroy() {
    try {
      widget.activeView.destroy();
    } catch (e) {
      throw e;
    }
  }

  move() {
    PictureAction _pa = new PictureAction(deviceUuid: _device.uuid, pictureId: widget.activeView.id, actionId: 4);
    storeAction(_pa);
  }

  Future<bool> share() async {
    PictureAction _pa = new PictureAction(deviceUuid: _device.uuid, pictureId: widget.activeView.id, actionId: 5);
    bool result = await Settings.share(picture: widget.activeView);
    if (result) storeAction(_pa);
    return result ? true : false;
  }

  //Aksiyonu toogle et
  Future<bool> toggleAction({@required Local.Action action}) async {
    PictureAction _pa = widget.activeView.findPictureAction(action.id) ?? PictureAction(actionId: action.id, pictureId: widget.activeView.id, deviceUuid: _device.uuid);

    if (_pa.id == null)
      await storeAction(_pa);
    else
      await destroyAction(_pa);
    return true;
  }

  //Aksiyonu sil.
  Future destroyAction(PictureAction _pa) async {
    try {
      setState(() {
        changeActionCount(_pa, -1);
        widget.activeView.actions.removeWhere((pictureAction) => pictureAction.id == _pa.id);
      });
      await _pa.destroy();
    } catch (e) {
      setState(() {
        changeActionCount(_pa, 1);
        widget.activeView.actions.add(_pa);
      });
    }
  }

  //Aksiyonu kaydet
  Future storeAction(PictureAction _pa) async {
    try {
      changeActionCount(_pa, 1);
      PictureAction newPA = await _pa.store();
      setState(() {
        widget.activeView.actions.add(newPA);
      });
    } catch (e) {
      setState(() {
        changeActionCount(_pa, -1);
        widget.activeView.actions.remove(_pa);
      });
      rethrow;
    }
  }

// Aksiyon change gore.
  void changeActionCount(PictureAction pa, int i) {
    if (pa.actionId == 1) // like
      widget.activeView.likeCount += i;
    else if (pa.actionId == 2) //fav
      widget.activeView.favoriteCount += i;
    else if (pa.actionId == 5) //share
      widget.activeView.shareCount += i;
  }
}

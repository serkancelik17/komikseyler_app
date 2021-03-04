import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:komix/business/models/ad.dart';
import 'package:komix/business/models/device/log.dart';
import 'package:komix/business/models/mixins/section_mixin.dart';
import 'package:komix/business/models/mixins/view_mixin.dart';
import 'package:komix/business/models/model.dart';
import 'package:komix/business/models/picture.dart';
import 'package:komix/business/util/ad_manager.dart';
import 'package:komix/business/util/config/env.dart';
import 'package:komix/business/util/settings.dart';
import 'package:komix/ui/molecules/slide_molecule.dart';

class CustomSliderOrganism extends StatefulWidget {
  final SectionMixin section;
  final ValueChanged<ViewMixin> viewChanged;
  final ValueChanged<Log> logChanged;
  final AdManager adManager;

  CustomSliderOrganism({Key key, this.section, this.viewChanged, this.logChanged, this.adManager}) : super(key: key);

  @override
  _CustomSliderOrganismState createState() => _CustomSliderOrganismState();
}

class _CustomSliderOrganismState extends State<CustomSliderOrganism> {
  _CustomSliderOrganismState();

  List<ViewMixin> _views = [];
  ViewMixin _activeView;
  Log _log;
  int _slideIndex = 0;
  int _lastViewPictureId = 1;
  CarouselController carouselController = CarouselController();
  SliderDirection _direction;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        _log = await getLog();
        await _getMoreSlides();
      } catch (e) {
        Navigator.pushReplacementNamed(context, "/error", arguments: [e]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CarouselSlider _carouseSlider = CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.6,
        onPageChanged: (index, reason) {
          _onPageChanged(index, reason);
        },
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        viewportFraction: 1,
      ),
      items: _views.map((view) {
        return SlideMolecule(view: view);
      }).toList(),
    );
    return (_views == null || _views.length == 0)
        ? Center(child: CircularProgressIndicator())
        : Flexible(
            child: Column(
              children: [
                _carouseSlider,
                Text(
                  (Env.env == 'dev')
                      ? "${_direction.toString()} activeWPI/lastWPI:${_activeView?.id}/${_lastViewPictureId.toString()} slideIndex:${_slideIndex.toString()} "
                              "picture:#" +
                          _activeView?.id.toString()
                      : "",
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
/*                ElevatedButton(
                    onPressed: () {
                      carouselController.jumpToPage(2);
                    },
                    child: Text("Jump 2"))*/
              ],
            ),
          );
  }

  Future<bool> _getMoreSlides() async {
    try {
      //List<ViewMixin> _newViews = await widget.section.getRepository().views(section: widget.section, page: _page++, limit: Env.pagePictureLimit);
      List<ViewMixin> _newViews =
          (await Picture().where(filters: {'category_id': widget.section.getId()}, fields: {'device_uuid': await Settings.getUuid(), 'last_view_picture_id': _lastViewPictureId, 'limit': Env.pagePictureLimit})).get().cast<ViewMixin>();

      if (_newViews.length > 0) {
        // Imajları cache et.
        prefetchImages(_newViews);
        //Reklamları satın almadıysa remlam ekle icerige
        //if ( _views.indexOf(_activeView) == _views.length - 2) return _getMoreSlides(++page);
        //İlk resmi varsayılan vap
        if (_views.length == 0) _activeView = _newViews[0];
        bool _checkShowingAd = await widget.adManager.checkShowingAd();
        widget.viewChanged(_activeView);
        _views.addAll(_newViews); // view leri listeye ekle
        if (_checkShowingAd) _views.add(Ad()); // Reklamı ekle
      }
      return true;
    } catch (e) {
      Navigator.pushReplacementNamed(context, "/error", arguments: [e]);
    }
  }

  // imajları cache eder
  bool prefetchImages(List<ViewMixin> pictures) {
    pictures.forEach((picture) {
      String imageUrl = Env.imageAssetsUrl + "/" + picture.path;
      precacheImage(NetworkImage(imageUrl), context);
    });
    return true;
  }

  _onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      _slideIndex = index;
      _activeView = _views[_slideIndex];
      widget.viewChanged(_activeView);
    });

    if (index > _views.length - 2) _getMoreSlides();

    if (_activeView.id > _lastViewPictureId) {
      widget.logChanged(_log); // Log degisti bilgisini üste gonder
      _lastViewPictureId = _activeView.id;
    }
  }

  Future<Log> getLog() async {
    try {
      Log _log;

      Model logsModel = (await Log().where(filters: {'device_uuid': (await Settings.getUuid()), 'category_id': widget.section.getId()}));
      if (logsModel.response.length > 0)
        _log = logsModel.response[0];
      else
        _log = await Log(categoryId: widget.section.getId(), deviceUuid: await Settings.getUuid(), lastViewPictureId: 0).store();

      return _log;
    } catch (e) {
      Navigator.pushReplacementNamed(context, "/error", arguments: [e]);
    }
  }
}

enum SliderDirection { backward, forward }

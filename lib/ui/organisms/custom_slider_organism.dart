import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komix/business/models/ad.dart';
import 'package:komix/business/models/category.dart';
import 'package:komix/business/models/device/log.dart';
import 'package:komix/business/models/mixins/section_mixin.dart';
import 'package:komix/business/models/mixins/view_mixin.dart';
import 'package:komix/business/models/model.dart';
import 'package:komix/business/models/picture.dart';
import 'package:komix/business/util/ad_manager.dart';
import 'package:komix/business/util/config/env.dart';
import 'package:komix/business/util/settings.dart';
import 'package:komix/ui/atoms/center_atom.dart';
import 'package:komix/ui/atoms/fa_icon_atom.dart';
import 'package:komix/ui/molecules/slide_molecule.dart';
import 'package:komix/ui/themes/custom_colors.dart';

class CustomSliderOrganism extends StatefulWidget {
  final SectionMixin section;
  final ValueChanged<ViewMixin> viewChanged;
  final ValueChanged<Log> logChanged;
  final AdManager adManager;

  CustomSliderOrganism(
      {Key key,
      this.section,
      this.viewChanged,
      this.logChanged,
      this.adManager})
      : super(key: key);

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
  bool _isLoading = true;
  int _page = 1;
  bool _isEmpty = false;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        _log = await getLog();
        await _getMoreSlides();
      } catch (e, s) {
        print(s.toString());
        Navigator.pushReplacementNamed(context, "/error", arguments: [e]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading == true)
        ? Center(child: CircularProgressIndicator())
        : (_isEmpty)
            ? buildIsEmpty()
            : (_isFinished)
                ? buildIsFinished()
                : buildCaroSlider(context);
  }

  Flexible buildCaroSlider(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.6,
              onPageChanged: (index, reason) {
                _onPageChanged(index, reason);
              },
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              initialPage: _slideIndex,
            ),
            items: _views.map((view) {
              return SlideMolecule(view: view);
            }).toList(),
          ),
          Text(
            (Env.env == 'dev')
                ? "activeWPI/lastWPI:${_activeView?.id}/${_lastViewPictureId.toString()} slideIndex:${_slideIndex.toString()} "
                        "picture:#" +
                    _activeView?.id.toString()
                : "",
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Column buildIsFinished() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FaIconAtom(
          icon: FontAwesomeIcons.images,
          size: 100,
          color: CustomColors.purple,
        ),
        Center(
            child: Text(
          'Bu kategorideki tüm içeriği gördünüz.',
          style: TextStyle(color: CustomColors.lightPurple),
        )),
        CenterAtom(
          child: Text(
            "Başka bir kategoriye geçebilirsiniz.",
            style: TextStyle(color: CustomColors.lightPurple),
          ),
        )
      ],
    );
  }

  Column buildIsEmpty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FaIconAtom(
          icon: FontAwesomeIcons.exclamationCircle,
          size: 100,
          color: CustomColors.purple,
        ),
        Center(
            child: Text(
          'Herhangi bir içerik bulunamadı.',
          style: TextStyle(color: CustomColors.lightPurple),
        )),
      ],
    );
  }

  Future<bool> _getMoreSlides() async {
    try {
      _isLoading = true;
      Picture _picture = Picture();
      _picture.setEndPoint('/devices/' +
          await Settings.getUuid() +
          '/' +
          ((widget.section is Category) ? 'categories' : 'actions') +
          '/' +
          widget.section.getId().toString() +
          '/pictures');
      List<ViewMixin> _newViews = (await _picture.where(fields: {
        'page': (_page++).toString(),
        'limit': Env.pagePictureLimit
      }))
          .get()
          .cast<ViewMixin>();

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
        if (_checkShowingAd && widget.section is Category)
          _views.add(Ad()); // Reklamı ekle
      } else {
        if (_page == 2)
          _isEmpty = true;
        else
          _isFinished = true;
      }
    } catch (e, s) {
      print(s.toString());
      Navigator.pushReplacementNamed(context, "/error", arguments: [e]);
    } finally {
      _isLoading = false;
      setState(() {});
    }
    return true;
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
      _log.lastViewPictureId = _lastViewPictureId;
      _log.viewCount++;
    }
  }

  Future<Log> getLog() async {
    Log _log;
    try {
      Model logsModel = (await Log(deviceUuid: await Settings.getUuid())
          .where(filters: {'category_id': widget.section.getId()}));
      if (logsModel.response.length > 0)
        _log = logsModel.response[0];
      else
        _log = await Log(
                categoryId: widget.section.getId(),
                deviceUuid: await Settings.getUuid())
            .store();
    } catch (e, s) {
      print(s.toString());
      Navigator.pushReplacementNamed(context, "/error", arguments: [e]);
    }
    return _log;
  }
}

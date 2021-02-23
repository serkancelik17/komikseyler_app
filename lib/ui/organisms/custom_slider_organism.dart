import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/business/config/env.dart';
import 'package:komik_seyler/business/models/ad.dart';
import 'package:komik_seyler/business/models/device/log.dart';
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/repositories/device/log_repository.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';
import 'package:komik_seyler/business/util/ad_manager.dart';
import 'package:komik_seyler/business/util/settings.dart';
import 'package:komik_seyler/ui/atoms/center_atom.dart';
import 'package:komik_seyler/ui/molecules/slide_molecule.dart';

class CustomSliderOrganism extends StatefulWidget {
  final DeviceRepository deviceRepository;
  final LogRepository logRepository;
  final SectionMixin section;
  final ValueChanged<ViewMixin> viewChanged;

  CustomSliderOrganism({Key key, this.section, this.viewChanged, deviceRepository, logRepository})
      : deviceRepository = deviceRepository ?? DeviceRepository(),
        logRepository = logRepository ?? LogRepository(),
        super(key: key);

  @override
  _CustomSliderOrganismState createState() => _CustomSliderOrganismState();
}

class _CustomSliderOrganismState extends State<CustomSliderOrganism> with WidgetsBindingObserver {
  List<ViewMixin> _views = [];
  ViewMixin _activeView;
  Log _log;
  int maxIndex = 0;
  int _page = 1;
  AdManager _adManager = AdManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMore();
    getLog();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return (_views == null || _views.length == 0)
        ? CenterAtom(child: CircularProgressIndicator())
        : Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.65,
                  onPageChanged: (index, reason) {
                    _onPageChange(index, reason);
                  },
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.8,
                ),
                items: _views.map((view) {
                  return SlideMolecule(view: view);
                }).toList(),
              ),
              //IndicatorsRowMolecule(views: widget.views, activeView: widget.activeView),
            ],
          );
  }

  Future<void> getMore() async {
    //List<ViewMixin> _newViews = await widget.section.getRepository().views(section: widget.section, page: _page++, limit: Env.pagePictureLimit);
    List<ViewMixin> _newViews = (await Picture().where(parameters: {'filter[category_id]': 1, 'filter[device_uuid]': await Settings.getUuid(), 'limit': Env.pagePictureLimit, 'page': _page++}, isPaginate: true)).get().cast<ViewMixin>();

    if (_newViews.length > 0) {
      //İlk resmi varsayılan vap
      if (_views.length == 0) _activeView = _newViews[0];
      setState(() {
        widget.viewChanged(_activeView);
        _views.addAll(_newViews);
      });
    } else {}
    //Reklamları satın almadıysa remlam ekle icerige
    if (await _adManager.showAd()) _views.add(Ad());
  }

  _onPageChange(int index, CarouselPageChangedReason reason) {
    setState(() {
      _activeView = _views[index];
      widget.viewChanged(_activeView);
    });
    //Update lastView
    if (index > maxIndex && _activeView is Picture) {
      maxIndex = index;
      _log.viewCount = widget.section.viewCount++; // Sayıyı bir arttır.
      _log.lastViewPictureId = _activeView.id;
      _saveData(); //@todo kaldırılacak.
    }

    if (index == _views.length - 2) getMore();
  }

  _saveData() async {
    _log.update(); // Logu güncelle
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /* @override @TODO sayfa cıkışlarında ve back button da calıstırılacak.
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _saveData();
  }*/

  Future<void> getLog() async {
    Log log = (await Log().where(parameters: {
      'filter': {'device_uuid': (await Settings.getUuid()), 'category_id': widget.section.getId()}
    }))
        .first();

    print(log.toString());

    debugger(when: log == null, message: "log null döndü");
    this._log = log ?? Log(categoryId: widget.section.getId());
  }
}

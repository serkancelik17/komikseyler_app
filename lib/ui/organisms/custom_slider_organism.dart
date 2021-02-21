import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/sectionable.dart';
import 'package:komik_seyler/business/models/abstracts/viewable.dart';
import 'package:komik_seyler/business/models/ad.dart';
import 'package:komik_seyler/business/models/device/log.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/repositories/device/log_repository.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';
import 'package:komik_seyler/business/util/ad_manager.dart';
import 'package:komik_seyler/config/env.dart';
import 'package:komik_seyler/ui/atoms/center_atom.dart';
import 'package:komik_seyler/ui/molecules/slide_molecule.dart';

class CustomSliderOrganism extends StatefulWidget {
  final DeviceRepository deviceRepository;
  final LogRepository logRepository;
  final Sectionable section;
  final ValueChanged<Viewable> viewChanged;

  CustomSliderOrganism({Key key, this.section, this.viewChanged, deviceRepository, logRepository})
      : deviceRepository = deviceRepository ?? DeviceRepository(),
        logRepository = logRepository ?? LogRepository(),
        super(key: key);

  @override
  _CustomSliderOrganismState createState() => _CustomSliderOrganismState();
}

class _CustomSliderOrganismState extends State<CustomSliderOrganism> with WidgetsBindingObserver {
  int _page = 1;
  List<Viewable> _views = [];
  Viewable _activeView;
  Log _log;
  int maxIndex = 0;
  AdManager _adManager = AdManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMore();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _log = (await Log().where(filter: {'category_id': widget.section.getId()})).first ?? Log(categoryId: widget.section.getId());
    });
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
                  viewportFraction: 0.9,
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
    List<Viewable> _newViews = await widget.section.getRepository().views(section: widget.section, page: _page++, limit: Env.pagePictureLimit);

    if (_newViews.length > 0) {
      //İlk resmi varsayılan vap
      if (_views.length == 0) _activeView = _newViews[0];
      setState(() {
        widget.viewChanged(_activeView);
        _views.addAll(_newViews);
      });
    }
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
      _log.viewCount = widget.section.viewCount++; // Sayısı bir arttır.
      _log.lastViewPictureId = _activeView.id;
      _saveData();
    }

    if (index == _views.length - 2) getMore();
  }

  _saveData() {
    _log.update({'view_count': _log.viewCount, 'last_view_picture_id': _log.lastViewPictureId});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _saveData();
  }
}

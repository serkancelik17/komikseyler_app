import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/business/models/ad.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/config/env.dart';
import 'package:komik_seyler/ui/atoms/center_atom.dart';
import 'package:komik_seyler/ui/molecules/slide_molecule.dart';

class CustomSliderOrganism extends StatefulWidget {
  final SectionAbstract section;
  final ValueChanged<ViewAbstract> viewChanged;

  CustomSliderOrganism({Key key, this.section, this.viewChanged}) : super(key: key);

  @override
  _CustomSliderOrganismState createState() => _CustomSliderOrganismState();
}

class _CustomSliderOrganismState extends State<CustomSliderOrganism> {
  int _page = 1;
  List<ViewAbstract> _views = [];
  ViewAbstract _activeView;
  Device device;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMore();
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
                  onPageChanged: (i, r) {
                    _onPageChange(i, r);
                  },
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
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
    List<ViewAbstract> _newViews = await widget.section.getRepository().views(section: widget.section, page: _page++, limit: Env.pagePictureLimit);

    if (_newViews.length > 0) {
      //İlk resmi varsayılan vap
      if (_views.length == 0) _activeView = _newViews[0];
      setState(() {
        widget.viewChanged(_activeView);
        _views.addAll(_newViews);
      });
    }

    //if (!kIsWeb && _views.length > 0 && (DateTime.now().isAfter(_device?.option?.adsShowAfter ?? DateTime.now().add(Duration(days: 1)))))
    _views.add(Ad());
  }

  _onPageChange(int index, CarouselPageChangedReason reason) {
    setState(() {
      _activeView = _views[index];
      widget.viewChanged(_activeView);
    });
    //Update lastView
    widget.section.increaseViewCount(); // Sayısı bir arttır.
    //widget.section.changeLastWiewPictureId(_activeView);

    if (index == _views.length - 2) getMore();
  }
}

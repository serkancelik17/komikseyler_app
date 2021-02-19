import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/ui/molecules/slide_molecule.dart';

class ViewsSliderOrganism extends StatefulWidget {
  final List<ViewAbstract> views;
  final ViewAbstract activeView;
  final Function(int, CarouselPageChangedReason) onPageChange;

  ViewsSliderOrganism({@required this.views, @required this.onPageChange, @required this.activeView});

  @override
  _ViewsSliderOrganismState createState() => _ViewsSliderOrganismState();
}

class _ViewsSliderOrganismState extends State<ViewsSliderOrganism> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.65,
            onPageChanged: widget.onPageChange,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            viewportFraction: 1,
          ),
          items: widget.views.map((view) {
            return SlideMolecule(view: view);
          }).toList(),
        ),
        //IndicatorsRowMolecule(views: widget.views, activeView: widget.activeView),
      ],
    );
  }
}

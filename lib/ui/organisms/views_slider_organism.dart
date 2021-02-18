import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/ui/molecules/slide.dart';

class ViewsSliderOrganism extends StatefulWidget {
  final List<ViewAbstract> views;
  final Function(int, CarouselPageChangedReason) onPageChange;

  ViewsSliderOrganism({@required this.views, @required this.onPageChange});

  @override
  _ViewsSliderOrganismState createState() => _ViewsSliderOrganismState();
}

class _ViewsSliderOrganismState extends State<ViewsSliderOrganism> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.6,
        onPageChanged: widget.onPageChange,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        viewportFraction: 0.8,
      ),
      items: widget.views.map((view) {
        return Slide(view: view);
      }).toList(),
    );
  }
}

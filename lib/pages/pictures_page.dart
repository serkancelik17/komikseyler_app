import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/models/action.dart' as Local;
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/models/section.dart';
import 'package:komik_seyler/partials/bottomBar.dart';
import 'package:komik_seyler/repositories/picture_repository.dart';
import 'package:komik_seyler/util/settings.dart';

final mainScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class PicturesPage extends StatefulWidget {
  final Section section;

  PicturesPage({this.section});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PicturesPage> {
  PictureRepository _pictureRepository = new PictureRepository();
  List<Picture> pictures = [];
  int page = 1;
  Picture activePicture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMore();
  }

  @override
  Widget build(BuildContext context) {
    print("section is " + widget.section.toString());

    return Scaffold(
      appBar: Settings.buildAppBar(title: widget.section.getTitle()),
      body: CarouselSlider(
        options: CarouselOptions(
          height: 600.0,
          onPageChanged: pageChange,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          viewportFraction: 0.8,
        ),
        items: pictures.map((picture) {
          String pictureUrl = Settings.imageAssetsUrl + "/" + picture.path;
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                /* decoration: BoxDecoration(color: Colors.amber),*/
                child: Image.network(pictureUrl),
              );
            },
          );
        }).toList(),
      ),
      bottomNavigationBar: (activePicture is Picture) ? BottomBar(context: context, currentPicture: activePicture) : null,
    );
  }

  Future<void> getMore() async {
    List<Picture> _pictures = await widget.section.getRepository().pictures(section: widget.section, page: page++, limit: 20);
    setState(() {
      pictures.addAll(_pictures);
      //İlk resmi varsayılan vap
      if (activePicture == null) activePicture = _pictures[0];
    });
  }

  pageChange(int index, CarouselPageChangedReason reason) {
    setState(() {
      activePicture = pictures[index];
    });
    //Add hit
    _pictureRepository.addAction(action: new Local.Action(name: 'hit'), picture: pictures[index]);
    if (index == pictures.length - 2) getMore();
  }
}

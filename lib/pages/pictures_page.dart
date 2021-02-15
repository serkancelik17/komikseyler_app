import 'package:admob_flutter/admob_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  int pictureChangeCount = 0;
  List<Picture> pictures;
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

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: Settings.buildAppBar(title: widget.section.getTitle()),
        body: (pictures == null)
            ? Center(child: CircularProgressIndicator())
            : (pictures.length == 0)
                ? Center(child: Text('Herhangi bir içerik bulunamadı.'))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.6,
                          onPageChanged: pageChange,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          viewportFraction: 0.8,
                        ),
                        items: pictures.map((picture) {
                          return buildBuilder(picture);
                        }).toList(),
                      ),
                      activePicture.path != 'ads' ? Settings.getBannerAd() : SizedBox(width: 1),
                    ],
                  ),
        bottomNavigationBar: (activePicture is Picture && activePicture.path != 'ads') ? BottomBar(context: context, currentPicture: activePicture) : null,
      ),
    );
  }

  Builder buildBuilder(Picture picture) {
    String pictureUrl = Settings.imageAssetsUrl + "/" + picture.path;
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          /* decoration: BoxDecoration(color: Colors.amber),*/
          child: (picture.path == 'ads') ? Settings.getBannerAd(bannerSize: AdmobBannerSize.MEDIUM_RECTANGLE) : InteractiveViewer(maxScale: 4, minScale: 1, child: Image.network(pictureUrl)),
        );
      },
    );
  }

  Future<void> getMore() async {
    // try {
    List<Picture> _pictures = await widget.section.getRepository().pictures(section: widget.section, page: page++, limit: 5);
    setState(() {
      pictures ??= [];
      if (_pictures.length > 0) {
        //İlk resmi varsayılan vap
        if (pictures.length == 0) activePicture = _pictures[0];
        pictures.addAll(_pictures);
      }

      if (!kIsWeb && pictures.length > 0) pictures.add(Picture(path: 'ads'));
    });
/*    } catch (error) {
      Navigator.pushReplacementNamed(context, '/error', arguments: error);
    }*/
  }

  pageChange(int index, CarouselPageChangedReason reason) {
    pictureChangeCount++;

    setState(() {
      activePicture = pictures[index];
    });
    if (index == pictures.length - 2) getMore();
  }

  Future<bool> _onBackPressed() async {
    //Add hit
    _pictureRepository.addAction(action: new Local.Action(id: 3, name: 'hit'), picture: activePicture);
    return true;
  }
}

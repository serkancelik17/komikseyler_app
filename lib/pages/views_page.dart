import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:komik_seyler/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/models/ad.dart';
import 'package:komik_seyler/models/device.dart';
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/partials/bottomBar.dart';
import 'package:komik_seyler/repositories/device_repository.dart';
import 'package:komik_seyler/util/settings.dart';

class ViewsPage extends StatefulWidget {
  final SectionAbstract section;

  final _productIds = {'subscription_yearly'};
  InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];

  ViewsPage({this.section});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ViewsPage> {
  DeviceRepository _deviceRepository = new DeviceRepository();
  int pictureChangeCount = 0;
  List<ViewAbstract> views;
  int page = 1;
  ViewAbstract activeView;
  Device _device = new Device();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDevice();
    getMore();

    Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;

    widget._subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      widget._subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
  }

  @override
  Widget build(BuildContext context) {
    print("section is " + widget.section.toString());

    return Scaffold(
      appBar: Settings.buildAppBar(title: widget.section.getTitle()),
      body: (views == null)
          ? Center(child: CircularProgressIndicator())
          : (views.length == 0)
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
                      items: views.map((view) {
                        return buildBuilder(view);
                      }).toList(),
                    ),
                    (activeView is Ad || _device.showAd == 0) ? ElevatedButton(onPressed: _buyProduct, child: Text('Reklamları Kaldır')) : Settings.getBannerAd(),
                  ],
                ),
      bottomNavigationBar: (activeView is Ad) ? null : BottomBar(context: context, currentView: activeView),
    );
  }

  Builder buildBuilder(ViewAbstract view) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          /* decoration: BoxDecoration(color: Colors.amber),*/
          child: (view is Ad) ? Settings.getBannerAd(bannerSize: AdmobBannerSize.MEDIUM_RECTANGLE) : InteractiveViewer(maxScale: 4, minScale: 1, child: Image.network(Settings.imageAssetsUrl + "/" + view.getPath())),
        );
      },
    );
  }

  Future<void> getMore() async {
    // try {
    List<ViewAbstract> _views = await widget.section.getRepository().views(section: widget.section, page: page++, limit: Settings.pagePictureLimit);
    setState(() {
      views ??= [];
      if (_views.length > 0) {
        //İlk resmi varsayılan vap
        if (views.length == 0) activeView = _views[0];
        views.addAll(_views);
      }

      if (!kIsWeb && views.length > 0 && _device.showAd == 1) views.add(Ad());
    });
/*    } catch (error) {
      Navigator.pushReplacementNamed(context, '/error', arguments: error);
    }*/
  }

  pageChange(int index, CarouselPageChangedReason reason) {
    pictureChangeCount++;

    setState(() {
      activeView = views[index];
    });
    //Update lastView
    if (activeView is Picture) _deviceRepository.updateLastView(picture: activeView);

    if (index == views.length - 2) getMore();
  }

  getDevice() async {
    _device = await Settings.getDevice();
    setState(() {});
  }

  initStoreInfo() async {
    ProductDetailsResponse productDetailResponse = await widget._connection.queryProductDetails(widget._productIds);
    if (productDetailResponse.error == null) {
      setState(() {
        widget._products = productDetailResponse.productDetails;
      });
    }
  }

  _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // show progress bar or something
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // show error message or failure icon
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          // show success message and deliver the product.
        }
      }
    });
  }

  _buyProduct() {
    if (widget._products.length > 0) {
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: widget._products[0]);
      widget._connection.buyConsumable(purchaseParam: purchaseParam);
    } else {
      print("HATA: Product bulunamadı");
    }
  }
}

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/models/ad.dart';
import 'package:komik_seyler/models/category.dart' as Local;
import 'package:komik_seyler/models/device.dart';
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/repositories/device_repository.dart';
import 'package:komik_seyler/ui/atoms/banner_atom.dart';
import 'package:komik_seyler/ui/atoms/button_atom.dart';
import 'package:komik_seyler/ui/atoms/text_atom.dart';
import 'package:komik_seyler/ui/molecules/center_text.dart';
import 'package:komik_seyler/ui/organisms/app_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/bottom_app_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/views_slider_organism.dart';
import 'package:komik_seyler/util/settings.dart';

class ViewsTemplate extends StatefulWidget {
  final SectionAbstract section;

  final _productIds = {'subscription_yearly'};
/*  InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];*/

  ViewsTemplate({SectionAbstract section}) : section = section ?? Local.Category(id: 1, name: '{title}');

  @override
  _ViewsTemplateState createState() => _ViewsTemplateState();
}

class _ViewsTemplateState extends State<ViewsTemplate> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOrganism(
        title: CenterText(widget.section.getTitle()),
      ),
      body: (views == null)
          ? Center(child: CircularProgressIndicator())
          : (views.length == 0)
              ? CenterText("Herhangi bir içerik bulunamadı.")
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ViewsSliderOrganism(views: views, onPageChange: onPageChange),
                    (activeView is Ad || _device.showAd == 0) ? ButtonAtom(onPressed: () {}, child: TextAtom('Reklamları Kaldır')) : BannerAtom(),
                  ],
                ),
      bottomNavigationBar: (activeView is Picture) ? BottomAppBarOrganism(context: context, activeView: activeView) : null,
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

  getDevice() async {
    _device = await Settings.getDevice();
    setState(() {});
  }

  onPageChange(int index, CarouselPageChangedReason reason) {
    pictureChangeCount++;

    setState(() {
      activeView = views[index];
    });
    //Update lastView
    if (activeView is Picture) _deviceRepository.updateLastView(picture: activeView);

    if (index == views.length - 2) getMore();
  }

/*  initStoreInfo() async {
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
  }*/
}

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/business/models/category.dart' as Local;
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';
import 'package:komik_seyler/ui/molecules/center_text_molecule.dart';
import 'package:komik_seyler/ui/molecules/text_one_word_two_color_molecule.dart';
import 'package:komik_seyler/ui/organisms/app_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/bottom_navigation_bar_organism.dart';
import 'package:komik_seyler/ui/organisms/custom_slider_organism.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class ViewsTemplate extends StatefulWidget {
  final SectionAbstract section;

  ViewsTemplate({@required SectionAbstract section}) : section = section ?? Local.Category(id: 1, name: '{title}');

  @override
  _ViewsTemplateState createState() => _ViewsTemplateState();
}

class _ViewsTemplateState extends State<ViewsTemplate> {
  DeviceRepository _deviceRepository = new DeviceRepository();
  int pictureChangeCount = 0;
  List<ViewAbstract> views;
  int page = 1;
  ViewAbstract activeView;
  AdmobReward rewardAd;

/*  final _productIds = {'subscription_yearly'};
  InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];*/

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
  }
  //WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});

  /* rewardAd = AdmobReward(
      adUnitId: AdManager.rewardedAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
*/ /*          handleEvent(event, args, 'Reward');*/ /*
      },
    );
    rewardAd.load();

    Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOrganism(
        leading: IconButton(icon: Icon(Icons.west), onPressed: () => Navigator.of(context).pop()),
        title: CenterMolecule(TextOneWordTwoColorMolecule(
          text: widget.section.getTitle(),
          colors: [
            Colors.black,
            CustomColors.purple,
          ],
        )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSliderOrganism(
              section: widget.section,
              viewChanged: (activeView) {
                setState(() {
                  this.activeView = activeView;
                });
              }),
          //(DateTime.now().isAfter(widget.device?.option?.adsShowAfter ?? DateTime.now().add(Duration(days: 1)))) ? ((activeView is Ad) ? getAdButtons() : BannerAtom()) : Text(""),
        ],
      ),
      bottomNavigationBar: (activeView is Picture) ? BottomNavigationBarOrganism(context: context, activeView: activeView) : null,
    );
  }

  /* removeAds() async {
    try {
      //@TODO device.option icine aktarilacak.
      await _deviceRepository.update(device: widget.device, patch: {'show_ad': 0});
    } catch (e) {
      print(e.toString());
    }
    Navigator.pushNamed(context, "/");
  }

  _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // show progress bar or something
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // show error message or failure icon
          showPaymentErrorAlertDialog(context);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          // show success message and deliver the product.
          // showPaymentSuccessAlertDialog(context);
          removeAds();
        }
      }
    });
  }

  _buyProduct() {
    if (_products.length > 0) {
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: _products[0]);
      _connection.buyConsumable(purchaseParam: purchaseParam);
    } else {
      print("HATA: Product bulunamadı");
    }
  }

  showPaymentErrorAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ödeme Alınamadı."),
      content: Text("Ödemeniz herhangi bir nedenle alınamadı. Lütfen tekrar deneyiniz."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showPaymentSuccessAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ödeme Alındı."),
      content: Text("Tüm reklamlar kaldırıldı. Ödeme için teşekkürler."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Column getAdButtons() {
    List<ButtonAtom> buttons = [];

    buttons.add(ButtonWithIconMolecule(
      onTap: () {
        this._buyProduct();
      },
      child: Text('Reklamları Kaldır'),
      icon: FaIcon(FontAwesomeIcons.ad),
    ));

    buttons.add(ButtonWithIconMolecule(
      onTap: () async {
        if (await rewardAd.isLoaded) {
          rewardAd.show();
        }
      },
      child: Text('1 reklam izle 1 saat reklam görme.'),
      icon: FaIcon(FontAwesomeIcons.ad),
    ));

    return Column(children: buttons);
  }

  @override
  void dispose() {
    rewardAd.dispose();
    super.dispose();
  }

  initStoreInfo() async {
    ProductDetailsResponse productDetailResponse = await _connection.queryProductDetails(_productIds);
    if (productDetailResponse.error == null) {
      //setState(() {
      _products = productDetailResponse.productDetails;
      // });
    }
  }*/
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/business/util/ad_manager.dart';
import 'package:komik_seyler/ui/templates/views_template.dart';

class ViewsPage extends StatefulWidget {
  final SectionMixin section;
  ViewsPage({@required this.section});

  @override
  _ViewsPageState createState() => _ViewsPageState();
}

class _ViewsPageState extends State<ViewsPage> {
  int pictureChangeCount = 0;
  List<ViewMixin> views;
  int page = 1;
  ViewMixin activeView;
  AdManager _adManager = AdManager();
  StreamSubscription<List<PurchaseDetails>> subscription;

  @override
  void initState() {
    super.initState();

    //In APP Purchase
    Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;
    subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _adManager.listenToPurchaseUpdated(context, purchaseDetailsList);
    }, onDone: () {
      subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    _adManager.initStoreInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ViewsTemplate(widget.section, _adManager, activeView);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }
}

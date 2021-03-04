import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:komix/business/models/device.dart';
import 'package:komix/business/models/mixins/section_mixin.dart';
import 'package:komix/business/models/mixins/view_mixin.dart';
import 'package:komix/business/util/ad_manager.dart';
import 'package:komix/business/util/settings.dart';
import 'package:komix/ui/templates/views_template.dart';

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
  Device _device;
  AdManager adManager;
  Widget _view;
  StreamSubscription<List<PurchaseDetails>> subscription;

  @override
  void initState() {
    super.initState();
    _build();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //In APP Purchase
      Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;
      subscription = purchaseUpdated.listen((purchaseDetailsList) {
        adManager.listenToPurchaseUpdated(context, purchaseDetailsList);
      }, onDone: () {
        subscription.cancel();
      }, onError: (error) {
        // handle error here.
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _view ?? Text("");
  }

  _build() {
    Settings.getUuid().then((uuid) => {
          Device().find(id: uuid).then((device) {
            _device = device;
            adManager = AdManager(device);
            adManager.initStoreInfo();
            setState(() {
              _view = ViewsTemplate(widget.section, adManager, activeView);
            });
          }),
        });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

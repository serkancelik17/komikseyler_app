import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/routers/app_router.dart';
import 'package:komik_seyler/ui/themes/custom_theme.dart';

void main() {
  ///Include this in main() so purchases are enabled
  InAppPurchaseConnection.enablePendingPurchases();
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyApp> {
  AppRouter _appRouter = AppRouter();
  Device device;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //showPerformanceOverlay: false,
      //debugShowMaterialGrid: true,
      title: 'Komik Şeyler',
      theme: CustomTheme.lightTheme,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:komix/business/models/device.dart';
import 'package:komix/business/util/routers/app_router.dart';
import 'package:komix/ui/themes/custom_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize without device test ids
  Admob.initialize();
  InAppPurchaseConnection.enablePendingPurchases();
  //debugPaintSizeEnabled = true;
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
      debugShowCheckedModeBanner: false,
      title: 'Komix',
      theme: CustomTheme.lightTheme,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}

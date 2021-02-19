import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:komik_seyler/business/routers/app_router.dart';
import 'package:komik_seyler/ui/atoms/container_atom.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';
import 'package:komik_seyler/ui/themes/custom_theme.dart';

void main() {
  ///Include this in main() so purchases are enabled
  InAppPurchaseConnection.enablePendingPurchases();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyApp> {
  AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return ContainerAtom(
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.darkPurple,
          width: 5,
        ),
      ),
      child: MaterialApp(
        title: 'Komik Şeyler',
        theme: CustomTheme.lightTheme,
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}

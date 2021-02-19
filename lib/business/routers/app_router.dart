import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/ui/pages/home_page.dart';
import 'package:komik_seyler/ui/pages/views_page.dart';

class AppRouter {
  int fishId;
  RouteSettings settings;

  AppRouter({this.settings}) {
    this.settings ??= RouteSettings();
  }

  Route onGenerateRoute(settings) {
    final arguments = settings.arguments;

    print(settings.name);
    switch (settings.name) {
      case '/categories':
        return MaterialPageRoute(
          builder: (_) => ViewsPage(section: arguments[0], device: arguments[1]),
        );
        break;
/*      case '/error':
        return MaterialPageRoute(
          builder: (_) => ErrorPage(error: arguments),
        );
        break;*/
    }
    //return MaterialPageRoute(builder: (_) => ViewsPage(section: Category(id: 1, name: "Film Replikleri")));
    return MaterialPageRoute(builder: (_) => HomePage());
  }
}
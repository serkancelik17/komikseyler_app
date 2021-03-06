import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:komix/business/models/category.dart';
import 'package:komix/ui/pages/error_page.dart';
import 'package:komix/ui/pages/home_page.dart';
import 'package:komix/ui/pages/views_page.dart';

class AppRouter {
  int fishId;
  RouteSettings settings;

  AppRouter({this.settings}) {
    this.settings ??= RouteSettings();
  }

  Route onGenerateRoute(settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case '/sections':
        return MaterialPageRoute(
          builder: (_) => ViewsPage(section: arguments[0]),
        );
        break;
      case '/error':
        return MaterialPageRoute(
          builder: (_) => ErrorPage(exception: arguments[0]),
        );
        break;
    }

    String page = 'home';
    //if (page == 'viewTemplate') return MaterialPageRoute(builder: (_) => ViewsTemplate());
    if (page == 'view')
      return MaterialPageRoute(
          builder: (_) => ViewsPage(
              section: Category(
                  id: 1,
                  name: "{category_title}",
                  picturesCount: 0,
                  viewCount: 0)));
    return MaterialPageRoute(builder: (_) => HomePage());
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:komik_seyler/action_pictures.dart';
import 'package:komik_seyler/category_pictures.dart';
import 'package:komik_seyler/models/action.dart' as Local;
import 'package:komik_seyler/models/category.dart';
import 'package:komik_seyler/repositories/action_repository.dart';
import 'package:komik_seyler/repositories/category_repository.dart';
import 'package:komik_seyler/util/settings.dart';

void main() => runApp(MyApp());

final mainScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Komik Şeyler',
      theme: ThemeData(
        primaryColorBrightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: Settings.buildAppBar(title: "Komik Şeyler"),
        body: Center(child: Categories()),
      ),
      scaffoldMessengerKey: mainScaffoldMessengerKey,
    );
  }
}

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: getCategories(),
            builder: (context, AsyncSnapshot<List<Category>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    for (Category category in snapshot.data)
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          color: Colors.blue.shade300,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryPictures(
                                        category: category,
                                      ))),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 13,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                category.name,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        color: Colors.green,
                        onPressed: () async {
                          Local.Action _action = await getAction(actionName: 'like');
                          return Navigator.push(context, MaterialPageRoute(builder: (context) => ActionPictures(action: _action)));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 13,
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.favorite, color: Colors.white),
                                Text(
                                  " Beğendiklerim",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        color: Colors.blue,
                        onPressed: () async {
                          Local.Action _action = await getAction(actionName: 'favorite');
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ActionPictures(action: _action),
                            ),
                          );
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 13,
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.white),
                                Text(
                                  "Favorilerim",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ))),
                      ),
                    )
                  ],
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            }),
      ],
    );
  }

  Future<List<Category>> getCategories() async {
    CategoryRepository catRepo = CategoryRepository();
    return await catRepo.getCategories();
  }

  Future<Local.Action> getAction({@required actionName}) async {
    ActionRepository _actionRepository = ActionRepository();
    return await _actionRepository.getAction(actionName: actionName);
  }
}

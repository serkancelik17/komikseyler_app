import 'package:flutter/material.dart';
import 'package:komik_seyler/category_pictures.dart';
import 'package:komik_seyler/models/categories.dart';
import 'package:komik_seyler/repositories/category_repository.dart';

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
        appBar: AppBar(
          title: Text("Kategoriler"),
        ),
        body: Center(child: Categories()),
      ),
      scaffoldMessengerKey: mainScaffoldMessengerKey,
    );
  }
}

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> categories;
    return FutureBuilder(
        future: getCategories(),
        builder: (context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                for (Category category in snapshot.data)
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryPictures(
                                    categoryId: category.id,
                                  ))),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 9,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(category.name),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<List<Category>> getCategories() async {
    CategoryRepository catRepo = CategoryRepository();
    return await catRepo.all();
  }
}

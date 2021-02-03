import 'package:flutter/material.dart';
import 'package:komik_seyler/category_pictures.dart';
import 'package:komik_seyler/models/categories.dart';
import 'package:komik_seyler/repositories/category_repository.dart';

void main() => runApp(MyApp());

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
    );
  }
}

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> categories;
    //categories = getCategories();

    return FutureBuilder(
        future: getCategories(),
        builder: (context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                for (Category category in snapshot.data)
                  RaisedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPictures(
                                  categoryId: category.id,
                                ))),
                    child: Text(category.name),
                  )
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

import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/models/categories.dart';
import 'package:komik_seyler/models/category_picture.dart';
import 'package:komik_seyler/providers/api_provider.dart';
import 'package:komik_seyler/providers/provider.dart';

class CategoryRepository {
  Provider provider;

  CategoryRepository({this.provider}) {
    this.provider ??= ApiProvider();
  }

  Future<List<Category>> all() async {
    String endpoint = '/categories';
    List<Category> categories = [];

    var response = await provider.getResponse(endpoint);

    categories = categoryFromJson(response);

    return categories;
  }

  pictures({@required int categoryId, int page = 1, int limit = 10}) async {
    CategoryPicture categoryPicture;
    String endpoint = "/categories/" + categoryId.toString() + "/pictures?page=" + page.toString() + "&limit=" + limit.toString();

    var response = await provider.getResponse(endpoint);

    categoryPicture = categoryPictureFromJson(response);

    return categoryPicture.data;
  }
}

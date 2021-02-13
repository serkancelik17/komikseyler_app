import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/models/category.dart';
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/models/response.dart';
import 'package:komik_seyler/models/section.dart';
import 'package:komik_seyler/providers/api_provider.dart';
import 'package:komik_seyler/repositories/repository.dart';
import 'package:komik_seyler/util/settings.dart';

class CategoryRepository implements Repository {
  ApiProvider provider;

  CategoryRepository({this.provider}) {
    this.provider ??= ApiProvider();
  }

  Future<List<Category>> getCategories() async {
    String endpoint = "/devices/" + await Settings.getUuid() + '/categories';
    List<Category> categories = [];

    String apiResponse = await provider.getResponse(endpoint);

    categories = (responseFromJson(apiResponse)).data.map((categoryJson) => Category.fromJson(categoryJson)).toList();

    return categories;
  }

  pictures({@required Section section, int page = 1, int limit = 20}) async {
    String endpoint = "/devices/" + await Settings.getUuid() + "/categories/" + section.getId().toString() + "/pictures?page=" + page.toString() + "&limit=" + limit.toString();

    String apiResponse = await provider.getResponse(endpoint);

    List<Picture> pictures = (responseFromJson(apiResponse)).data.map((pictureJson) => Picture.fromJson(pictureJson)).toList();

    return pictures;
  }
}

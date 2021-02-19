import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/category.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/repositories/abstracts/repository_abstract.dart';
import 'package:komik_seyler/business/util/settings.dart';

class CategoryRepository implements RepositoryAbstract {
  ApiProvider provider;

  CategoryRepository({this.provider}) {
    this.provider ??= ApiProvider();
  }

  Future<List<Category>> getCategories() async {
    print("getDevice oncesi");
    String _uuid = await Settings.getUuid();
    print(_uuid.toString());
    String endpoint = "/devices/" + _uuid + '/categories';

    String apiResponse = await provider.getResponse(endpoint);

    return categoryFromJson(apiResponse);
  }

  Future<List<Picture>> views({@required SectionAbstract section, int page = 1, int limit = 20}) async {
    String _uuid = await Settings.getUuid();
    print(_uuid.toString());
    String endpoint = "/devices/" + _uuid + "/categories/" + section.getId().toString() + "/pictures?page=" + page.toString() + "&limit=" + limit.toString();

    String apiResponse = await provider.getResponse(endpoint);
    List<Picture> pictures = pictureFromJson(apiResponse);

    return pictures;
  }
}
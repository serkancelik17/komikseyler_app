import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/models/category.dart';
import 'package:komik_seyler/models/device.dart';
import 'package:komik_seyler/models/picture.dart';
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
    print("getDevice oncesi");
    Device _device = await Settings.getDevice();
    print(_device.toString());
    String endpoint = "/devices/" + _device.id.toString() + '/categories';
    List<Category> categories = [];

    String apiResponse = await provider.getResponse(endpoint);

    return categoryFromJson(apiResponse);
  }

  Future<List<Picture>> pictures({@required Section section, int page = 1, int limit = 20}) async {
    Device _device = await Settings.getDevice();
    String endpoint = "/devices/" + _device.id.toString() + "/categories/" + section.getId().toString() + "/pictures?page=" + page.toString() + "&limit=" + limit.toString();

    String apiResponse = await provider.getResponse(endpoint);
    List<Picture> pictures = pictureFromJson(apiResponse);

    return pictures;
  }
}

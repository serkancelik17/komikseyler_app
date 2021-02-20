import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/category.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/repositories/abstracts/repository_abstract.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';
import 'package:komik_seyler/business/util/settings.dart';

class CategoryRepository implements RepositoryAbstract {
  ApiProvider provider;
  DeviceRepository deviceRepository;

  CategoryRepository({this.provider, this.deviceRepository}) {
    this.provider ??= ApiProvider();
    this.deviceRepository ??= DeviceRepository();
  }

  Future<List<Category>> getCategories() async {
    print("getDevice oncesi");
    Device _device = await deviceRepository.get();
    print(_device.toString());
    String endpoint = "/devices/" + _device.uuid + '/categories';

    String apiResponse = await provider.get(endpoint);

    return categoryFromJson(apiResponse);
  }

  Future<List<Picture>> views({@required SectionAbstract section, int page = 1, int limit = 20}) async {
    String _uuid = await Settings.getUuid();
    print(_uuid.toString());
    String endpoint = "/devices/" + _uuid + "/categories/" + section.getId().toString() + "/pictures?page=" + page.toString() + "&limit=" + limit.toString();

    String apiResponse = await provider.get(endpoint);
    List<Picture> pictures = pictureFromJson(apiResponse);

    return pictures;
  }
}

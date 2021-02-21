import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/category.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';
import 'package:komik_seyler/business/repositories/abstracts/repository_mixin.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';
import 'package:komik_seyler/business/util/settings.dart';

class CategoryRepository extends ModelRepository with RepositoryMixin {
  ApiProvider provider;
  DeviceRepository deviceRepository;

  CategoryRepository({this.provider, this.deviceRepository}) {
    this.provider ??= ApiProvider();
    this.deviceRepository ??= DeviceRepository();
  }

  Future<List<Category>> getCategories() async {
    Device _device = await deviceRepository.get(viaLocal: false);
    print(_device.toString());
    String endpoint = "/devices/" + _device.uuid + '/categories';

    Response _response = await provider.get(endpoint);

    return categoryFromJson(jsonEncode(_response.data));
  }

  Future<List<Picture>> views({@required SectionMixin section, int page = 1, int limit = 20}) async {
    String _uuid = await Settings.getUuid();
    print(_uuid.toString());
    String endpoint = "/devices/" + _uuid + "/categories/" + section.getId().toString() + "/pictures?page=" + page.toString() + "&limit=" + limit.toString();

    Response _response = await provider.get(endpoint);
    List<Picture> pictures = pictureFromJson(jsonEncode(_response.data));

    return pictures;
  }
}

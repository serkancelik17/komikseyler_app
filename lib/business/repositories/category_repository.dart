import 'dart:convert';

import 'package:komik_seyler/business/models/category.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/business/models/response/pageless_response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';
import 'package:komik_seyler/business/repositories/abstracts/repository_mixin.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';

class CategoryRepository extends ModelRepository with RepositoryMixin {
  ApiProvider provider;
  DeviceRepository deviceRepository;

  CategoryRepository({this.provider, this.deviceRepository}) {
    this.provider ??= ApiProvider();
    this.deviceRepository ??= DeviceRepository();
  }

  Future<List<Category>> getCategories() async {
    Device _device = (await deviceRepository.get(viaLocal: false));
    print(_device.toString());
    String endpoint = "/devices/" + _device.uuid + '/categories';

    PagelessResponse _response = (await provider.get(endpoint)) as PagelessResponse;

    return categoryFromJson(jsonEncode(_response.data));
  }

  @override
  Future<List<ViewMixin>> views({SectionMixin section, int page = 1, int limit = 20}) {
    // TODO: implement views
    throw UnimplementedError();
  }

/*  Future<List<Picture>> views({@required SectionMixin section, int page = 1, int limit = 20}) async {
    String _uuid = await Settings.getUuid();
    print(_uuid.toString());
    String endpoint = "/pictures?page=" + page.toString() + "&limit=" + limit.toString();

    Response _response = await provider.get(endpoint);
    List<Picture> pictures = pictureFromJson(jsonEncode(_response.data));

    return pictures;
  }*/
}

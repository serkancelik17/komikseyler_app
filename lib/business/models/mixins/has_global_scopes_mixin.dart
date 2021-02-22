import 'package:komik_seyler/business/models/device/option.dart';
import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/models/response.dart';

class HasGlobalScopesMixin {
  Future<Map<String, dynamic>> where({Map<String, dynamic> filter}) async {
    Response response = await Model.repository.where(model: this, filter: filter);
    return response.data[0];
  }

  Future<bool> store() async {
    Response response = await Model.repository.store(model: this);
    return response.success;
  }

  Future<Model> update() async {
    Response response = await Model.repository.update(model: this);
    return Option.fromJson(response.data[0]);
  }

  Future<bool> destroy() async {
    Response response = await Model.repository.destroy(model: this);
    return response.success;
  }
}

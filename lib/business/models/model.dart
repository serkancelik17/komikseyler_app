import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/business/models/device/log.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';

abstract class Model {
  dynamic uniqueId;
  ModelRepository repository;
  String tableName;
  List<Model> models;

  Model({@required this.repository, @required this.uniqueId, @required this.tableName});

  Model find(dynamic id) => this;

  Future<bool> store() async {
    Response response = await this.repository.store(model: this);
    return response.success;
  }

  Future<Response> update(Map<String, dynamic> patch) async {
    Response response = await this.repository.update(model: this, patch: patch);
    return response.data['option'];
  }

  Future<bool> destroy() async {
    Response response = await this.repository.destroy(model: this);
    return response.success;
  }

  Future<List<Model>> where({Map<String, dynamic> filter, bool addDeviceId = false}) async {
    Response response = await this.repository.where(model: this, filter: filter);
    models = List<Model>.from(response.data[this.tableName].map((x) => Log.fromJson(x)));
    return models;
  }
}

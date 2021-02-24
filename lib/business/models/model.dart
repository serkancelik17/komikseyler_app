import 'dart:convert';

import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/interfaces/json_able.dart';
import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';
import 'package:komik_seyler/business/util/settings.dart';

abstract class Model with JsonAble {
  dynamic uniqueId;
  static ModelRepository repository;
  String endPoint;
  Device device;
  List _response;

  Model({repository, this.endPoint, dynamic uniqueId}) : uniqueId = uniqueId ?? 0 {
    Model.repository = repository ?? null;
  }

  Model fromRawJson(String str) {
    return this.fromJson(json.decode(str));
  }

  Future<Model> find({dynamic id}) async {
    id ??= this.uniqueId;
    Model _model = (await Model.repository.where(model: this, parameters: {'filter[' + (runtimeType == Device ? 'uuid' : 'id') + ']'.toString(): id})).first();
    return _model;
  }

  Future<String> getEndPoint() async {
    //if (device == null) device = await this.find(uniqueId: await Settings.getUuid());

    endPoint = endPoint.replaceAll("{{device_uuid}}", await Settings.getUuid());
    return this.endPoint;
  }

  Future<Model> where({Map<String, dynamic> parameters, bool isPaginate = false}) async {
    List response = await Model.repository.where(model: this, parameters: parameters, isPaginate: isPaginate);
    response = response.map((e) => this.fromJson(e)).toList();
    _response = response;
    return this;
  }

  Model first() {
    return this._response[0];
  }

  List<Model> get() {
    return this._response;
  }

  Future<bool> store() async {
    bool response = await Model.repository.store(model: this);
    return response;
  }

  Future<bool> update() async {
    bool response = await Model.repository.update(model: this);
    return response;
    //return Option.fromJson(response.data[0]);
  }

  Future<bool> destroy() async {
    bool response = await Model.repository.destroy(model: this);
    return response;
  }
}

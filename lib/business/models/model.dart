import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/interfaces/json_able.dart';
import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';

abstract class Model with JsonAble {
  dynamic uniqueId;
  static ModelRepository repository;
  String endPoint;
  Device device;
  List _response;

  Model({@required repository, @required this.endPoint, @required dynamic uniqueId})
      : uniqueId = uniqueId ?? 0,
        assert(repository != null),
        assert(endPoint != null) {
    Model.repository = repository;
  }

  Model fromRawJson(String str) {
    return this.fromJson(json.decode(str));
  }

  Future<String> getEndPoint() async {
    if (device == null) device = await DeviceRepository().get();

    endPoint = endPoint.replaceAll("{{device_uuid}}", device.uuid);
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

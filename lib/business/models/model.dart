import 'dart:convert';
import 'dart:io';

import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/interfaces/json_able.dart';
import 'package:komik_seyler/business/models/response/response.dart';
import 'package:komik_seyler/business/repositories/repository.dart';

abstract class Model with JsonAble {
  dynamic uniqueId;
  Repository repository;
  String endPoint;
  Device device;
  List<Model> _response;

  Model({repository, this.endPoint, dynamic uniqueId})
      : uniqueId = uniqueId ?? 0,
        repository = repository ?? null;

  Model fromRawJson(String str) {
    return this.fromJson(json.decode(str));
  }

  Future<Model> find({dynamic id}) async {
    id ??= this.uniqueId;
    Model _model = (await this.where(parameters: {'filters[' + ((this is Device) ? 'uuid' : 'id') + ']': id}, isPaginate: false)).first();
    return _model;
  }

  Future<String> getEndPoint() async {
    return this.endPoint;
  }

  Future<Model> where({Map<String, dynamic> parameters, bool isPaginate = false}) async {
    _response = (await repository.where(model: this, parameters: parameters, paginateType: PaginateType.simplePaginate));
    return this;
  }

  Model first() {
    return _response[0];
  }

  List<Model> get() {
    return _response;
  }

  Future<Model> store() async {
    Model model = await this.repository.store(model: this);
    return model;
  }

  Future<bool> update() async {
    bool response = await this.repository.update(model: this);
    return response;
    //return Option.fromJson(response.data[0]);
  }

  Future<Model> firstOrNew(Map<String, dynamic> parameters) async {
    Model _model;
    _model = (await this.where(parameters: parameters, isPaginate: false)).first();
    if (_model == null) {
      _model = this.fromJson(parameters);
    }

    return _model;
  }

  Future<Model> firstOrCreate(Map<String, dynamic> parameters) async {
    Model _model;
    _model = (await this.where(parameters: parameters, isPaginate: false)).first();
    if (_model == null) {
      _model = this.fromJson(parameters);
      _model = await _model.store();

      if (!(_model is Model)) throw HttpException('Model store edilemedi.' + _model.toString());
    }
    return _model;
  }

  /// Veriyi gunceller veya kaydeder
  Future<Model> updateOrCreate(Map<String, dynamic> matches, Map<String, dynamic> changes) async {
    Model _model;

    _model = (await this.where(parameters: matches, isPaginate: false)).first();

    if (_model == null) {
      matches.addAll(changes);
      _model = await this.fromJson(matches).store();

      if (!(_model is Model)) throw HttpException('Model kayıt edilemedi.' + _model.toString());
    }
    return _model;
  }

  Future<bool> destroy() async {
    bool response = await this.repository.destroy(model: this);
    return response;
  }
}

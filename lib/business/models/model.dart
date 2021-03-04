import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:komix/business/models/device.dart';
import 'package:komix/business/models/interfaces/json_able.dart';
import 'package:komix/business/models/response/response.dart';
import 'package:komix/business/repositories/repository.dart';

abstract class Model with JsonAble {
  dynamic uniqueId;
  Repository repository;
  String endPoint;
  Device device;
  List<Model> response;
  PaginateType paginateType;

  Model({repository, @required this.endPoint, @required dynamic uniqueId, PaginateType paginateType})
      : uniqueId = uniqueId ?? 0,
        repository = repository ?? Repository(),
        paginateType = paginateType;

  Model fromRawJson(String str) {
    return this.fromJson(json.decode(str));
  }

  Future<Model> find({dynamic id}) async {
    id ??= this.uniqueId;
    Model _model = (await this.where(filters: {((this is Device) ? 'uuid' : 'id'): id})).first();
    return _model;
  }

  Future<String> getEndPoint() async {
    return this.endPoint;
  }

  Future<Model> where({Map<String, dynamic> filters, Map<String, dynamic> fields}) async {
    print("PaginateType is " + this.paginateType.toString());
    Map<String, dynamic> parameters = {};
    filters ??= {};
    fields ??= {};

    //Eğer filtre varsa parametrelere ekle.
    if (filters.length > 0) parameters.addAll(createFilters(filters));
    //Eğer field istegi varsa parametrelere ekle
    if (fields.length > 0) parameters.addAll(fields);

    response = (await repository.where(model: this, parameters: parameters, paginateType: this.paginateType));
    return this;
  }

  Model first() {
    return response[0];
  }

  List<Model> get() {
    return response;
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
    _model = (await this.where(filters: parameters)).first();
    if (_model == null) {
      _model = this.fromJson(parameters);
    }

    return _model;
  }

  Future<Model> firstOrCreate(Map<String, dynamic> fields) async {
    Model _model;
    _model = (await this.where(filters: fields)).first();
    if (_model == null) {
      _model = this.fromJson(fields);
      _model = await _model.store();

      if (!(_model is Model)) throw HttpException('Model store edilemedi.' + _model.toString());
    }
    return _model;
  }

  /// Veriyi gunceller veya kaydeder
  Future<Model> updateOrCreate(Map<String, dynamic> matches, Map<String, dynamic> changes) async {
    Model _model;

    //Model var mı yok mu kontrol et.
    _model = (await this.where(filters: matches)).first();

    if (_model == null) {
      //March ile change leri ekle
      matches.addAll(changes);
      //Yeni modeli kaydet
      _model = await this.fromJson(matches).store();

      if (!(_model is Model)) throw HttpException('Model kayıt edilemedi.' + _model.toString());
    } else {
      changes.forEach((key, value) {
        Map modelJson = _model.toJson();
        modelJson.addAll(changes);
        _model.fromJson(modelJson).update();
      });
    }
    return _model;
  }

  Map<String, String> createFilters(Map<String, dynamic> fields) {
    Map<String, String> filters = {};
    //Value leri filter sekline cevir.
    fields.forEach((key, value) {
      filters['filters[' + key.toString() + ']'] = value.toString();
    });
    return filters;
  }

  Future<bool> destroy() async {
    bool response = await this.repository.destroy(model: this);
    return response;
  }
}

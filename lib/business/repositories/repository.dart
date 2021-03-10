import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:komix/business/models/model.dart';
import 'package:komix/business/models/response/paginate_response.dart';
import 'package:komix/business/models/response/response.dart';
import 'package:komix/business/models/response/simple_paginate_response.dart';
import 'package:komix/business/providers/api_provider.dart';

class Repository {
  ApiProvider apiProvider;
  Response response;

  Repository({apiProvider, response}) {
    this.apiProvider = apiProvider ?? ApiProvider();
    this.response ??= Response();
  }

  //Future<Model> find() => Future.value(Device());

  Future<Model> store({@required Model model}) async {
    Model _model;
    String _modelJson = json.encode(model.toJson());
    String _endPoint = model.getEndPoint();
    String _apiResponse = await apiProvider.post(_endPoint, _modelJson);
    Response response = this.response.fromRawJson(_apiResponse);
    if (response.success)
      _model = model.fromJson(response.metaData.data[0]);
    else
      log(response.message);

    return _model;
  }

  Future<bool> update({@required Model model}) async {
    String _endPoint = model.getEndPoint() + '/' + model.uniqueId.toString();
    String _rawJson = await apiProvider.patch(_endPoint, jsonEncode(model));
    Response response = this.response.fromRawJson(_rawJson);
    return response.success;
  }

  Future<bool> destroy({@required Model model}) async {
    String _endPoint = model.getEndPoint() + '/' + model.uniqueId.toString();
    Response response = Response().fromRawJson(await apiProvider.delete(_endPoint));
    return response.success;
  }

  Future<List<Model>> where({@required Model model, @required Map<String, dynamic> parameters, @required paginateType}) async {
    List _parameterList = [];
    parameters.forEach((key, value) {
      if (value is String || value is int) _parameterList.add('$key=$value');

      if (value is Map) {
        value.forEach((mapKey, mapValue) {
          _parameterList.add('$key[$mapKey]=$mapValue');
        });
      }
    });

    String _endPoint = model.getEndPoint() + ((_parameterList.length > 0) ? "?" + _parameterList.join("&") : '').toString();
    List<Model> _models = [];
    String _apiResponse = await apiProvider.get(_endPoint);
    List<dynamic> _data;
    if (paginateType == PaginateType.simple) {
      this.response = SimplePaginateResponse().fromRawJson(_apiResponse);
    } else if (paginateType == PaginateType.paginate) {
      this.response = PaginateResponse().fromRawJson(_apiResponse);
    } else if (paginateType == PaginateType.none) {
      this.response = Response().fromRawJson(_apiResponse);
    }
    if (this.response.success == true)
      _data = this.response.metaData.data;
    else // Response sorunu var
      throw Exception('Veri getirilirken hata oluştu.(whereResponseProblem)');

    debugger(when: _data == null, message: 'data boş döndü');

    _data.forEach((modelJson) {
      _models.add(model.fromJson(modelJson));
    });

    print("Response:" + _models.toString());

    return _models;
  }
}

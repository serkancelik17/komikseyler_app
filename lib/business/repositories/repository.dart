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

  Repository({apiProvider}) {
    this.apiProvider = apiProvider ?? ApiProvider();
  }

  //Future<Model> find() => Future.value(Device());

  Future<Model> store({@required Model model}) async {
    Model _model;
    Response response = Response().fromRawJson(await apiProvider.post(model.getEndPoint(), json.encode(model.toJson())));
    if (response.success)
      _model = model.fromJson(response.metaData.data[0]);
    else
      log(response.message);

    return _model;
  }

  Future<bool> update({@required Model model}) async {
    String _endPoint = model.getEndPoint() + '/' + model.uniqueId.toString();
    Response response = Response().fromRawJson(await apiProvider.patch(_endPoint, jsonEncode(model)));
    return response.success;
  }

  Future<bool> destroy({@required Model model}) async {
    String _endPoint = model.getEndPoint() + '/' + model.uniqueId.toString();
    Response response = Response().fromRawJson(await apiProvider.delete(_endPoint));
    return response.success;
  }

  Future<List<Model>> where({@required Model model, @required Map<String, dynamic> parameters, paginateType}) async {
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
    Response _response;
    List<dynamic> _data;
    if (paginateType == PaginateType.simple) {
      _response = SimplePaginateResponse().fromRawJson(_apiResponse);
    } else if (paginateType == PaginateType.paginate) {
      _response = PaginateResponse().fromRawJson(_apiResponse);
    } else if (paginateType == PaginateType.none) {
      _response = Response().fromRawJson(_apiResponse);
    }
    if (_response.success == true)
      _data = _response.metaData.data;
    else // Response sorunu var
      log(_response.message, name: "response_error");

    debugger(when: _data == null, message: 'data boş döndü');

    _data.forEach((modelJson) {
      _models.add(model.fromJson(modelJson));
    });

    print("Response:" + _models.toString());

    return _models;
  }
}

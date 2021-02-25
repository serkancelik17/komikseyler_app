import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/models/response/get_response.dart';
import 'package:komik_seyler/business/models/response/simple_paginate_response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';

abstract class Repository {
  ApiProvider apiProvider;

  Repository({apiProvider}) {
    this.apiProvider = apiProvider ?? ApiProvider();
  }

  //Future<Model> find() => Future.value(Device());

  Future<bool> store({@required Model model}) async {
    GetResponse response = GetResponse().fromRawJson(await apiProvider.post(await model.getEndPoint(), jsonEncode(model)));
    return response.success;
  }

  Future<bool> update({@required Model model}) async {
    String _endPoint = await model.getEndPoint() + '/' + model.uniqueId.toString();
    GetResponse response = GetResponse().fromRawJson(await apiProvider.patch(_endPoint, jsonEncode(model)));
    return response.success;
  }

  Future<bool> destroy({@required Model model}) async {
    String _endPoint = await model.getEndPoint() + '/' + model.uniqueId.toString();
    GetResponse response = GetResponse().fromRawJson(await apiProvider.delete(_endPoint));
    return response.success;
  }

  Future<List<Model>> where({@required Model model, @required Map<String, dynamic> parameters, bool isPaginate = false}) async {
    List _parameterList = [];
    parameters.forEach((key, value) {
      if (value is String || value is int) _parameterList.add('$key=$value');

      if (value is Map) {
        value.forEach((mapKey, mapValue) {
          _parameterList.add('$key[$mapKey]=$mapValue');
        });
      }
    });

    String _endPoint = await model.getEndPoint() + "?" + _parameterList.join("&");
    var _response;
    List<Model> _models = [];
    List<dynamic> _data;
    String _apiResponse = await apiProvider.get(_endPoint);
    if (isPaginate) {
      SimplePaginateResponse _response = SimplePaginateResponse().fromRawJson(_apiResponse);
      _data = _response.data.data;
    } else {
      GetResponse _response = GetResponse().fromRawJson(_apiResponse);
      _data = _response.data;
    }
    //debugger(when: _data == null, message: 'data boş döndü');

    _data.forEach((modelJson) {
      _models.add(model.fromJson(modelJson));
    });

    print("Response:" + _models.toString());

    return _models;
  }
}

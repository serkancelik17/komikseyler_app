import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/models/response/page_response.dart';
import 'package:komik_seyler/business/models/response/pageless_response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';

abstract class ModelRepository {
  ApiProvider apiProvider;

  ModelRepository({apiProvider}) {
    this.apiProvider = apiProvider ?? ApiProvider();
  }

  //Future<Model> find() => Future.value(Device());

  Future<bool> store({@required Model model}) async {
    PagelessResponse response = PagelessResponse.fromRawJson(await apiProvider.post(await model.getEndPoint(), jsonEncode(model)));
    return response.success;
  }

  Future<bool> update({@required Model model}) async {
    String _endPoint = await model.getEndPoint() + '/' + model.uniqueId.toString();
    PagelessResponse response = PagelessResponse.fromRawJson(await apiProvider.patch(_endPoint, jsonEncode(model)));
    return response.success;
  }

  Future<bool> destroy({@required Model model}) async {
    String _endPoint = await model.getEndPoint() + '/' + model.uniqueId.toString();
    PagelessResponse response = PagelessResponse.fromRawJson(await apiProvider.delete(_endPoint));
    return response.success;
  }

  Future<List> where({@required Model model, @required Map<String, dynamic> parameters, bool isPaginate = false}) async {
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
    List<dynamic> _data;
    if (isPaginate) {
      _response = PageResponse.fromRawJson(await apiProvider.get(_endPoint));
      _data = _response.data.data;
    } else {
      _response = PagelessResponse.fromRawJson(await apiProvider.get(_endPoint));
      _data = _response.data;
    }

    print("Response:" + _response.toString());

    return _data;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/util/settings.dart';

abstract class ModelRepository {
  ApiProvider apiProvider;
  final String endPointPattern;
  Device device;

  ModelRepository({this.endPointPattern, apiProvider}) {
    this.apiProvider = apiProvider ?? ApiProvider();
  }

  Future<Model> find() => Future.value(Device());

  Future<Response> store({@required Model model}) async {
    Response response = await apiProvider.post(await endPoint, jsonEncode(model));
    return response;
  }

  Future<Response> update({@required Model model, @required Map<String, dynamic> patch}) async {
    String _endPoint = await endPoint + '/' + model.uniqueId.toString();
    Response response = await apiProvider.patch(_endPoint, jsonEncode(patch));
    return response;
  }

  Future<Response> destroy({@required Model model}) async {
    String _endPoint = await endPoint + '/' + model.uniqueId.toString();
    Response response = await apiProvider.delete(_endPoint);
    return response;
  }

  Future<Response> where({@required Model model, @required Map<String, dynamic> filter}) async {
    List filterList = [];
    filter.forEach((key, value) {
      filterList.add('filter[$key]=$value');
    });

    String _endPoint = await endPoint + "?" + filterList.join("&");

    Response _response = await apiProvider.get(_endPoint);

    print("Response:" + _response.toString());

    return _response;
  }

  Future<String> get endPoint async {
    return endPointPattern.replaceAll('{device_uuid}', (await Settings.getUuid()));
  }
}
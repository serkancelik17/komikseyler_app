import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/models/device.dart';
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/models/response.dart';
import 'package:komik_seyler/providers/api_provider.dart';
import 'package:komik_seyler/util/settings.dart';

class DeviceRepository {
  ApiProvider provider;

  DeviceRepository({this.provider}) {
    this.provider ??= ApiProvider();
  }

  Future<Device> get({@required int id}) async {
    String endPoint = "/devices/" + id.toString();
    Device _device = deviceFromJson(await provider.getResponse(endPoint));
    return _device;
  }

  Future<Device> store({@required Device device}) async {
    String endpoint = '/devices';
    String apiResponse = await provider.postResponse(endpoint, jsonEncode(device));
    return deviceFromJson(apiResponse);
  }

  Future<Response> updateLastView({@required Picture picture}) async {
    Device _device = await Settings.getDevice();
    String endpoint = '/devices/' + _device.id.toString() + '/update_last_view/' + picture.id.toString();
    try {
      Response response = responseFromJson(await provider.getResponse(endpoint));

      return response;
    } catch (e) {
      throw e;
    }
  }
}

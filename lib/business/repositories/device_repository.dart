import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/util/settings.dart';

class DeviceRepository {
  ApiProvider provider;

  DeviceRepository({this.provider}) {
    this.provider ??= ApiProvider();
  }

  Future<Device> get({@required String uuid}) async {
    String endPoint = "/devices/" + uuid;
    print("devices.get : " + endPoint);
    // try {
    String response = await provider.getResponse(endPoint);
    Device _device = deviceFromJson(response);
    return _device;
/*    } catch (e) {
      throw e;
    }*/
  }

  Future<Device> store({@required Device device}) async {
    String endpoint = '/devices';
    String apiResponse = await provider.postResponse(endpoint, jsonEncode(device));
    return deviceFromJson(apiResponse);
  }

  Future<Response> updateLastView({@required Picture picture}) async {
    Device _device = await Settings.getDevice();
    String endpoint = '/devices/' + _device.uuid + '/update_last_view/' + picture.id.toString();
    try {
      Response response = responseFromJson(await provider.getResponse(endpoint));

      return response;
    } catch (e) {
      throw e;
    }
  }
}

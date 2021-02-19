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

  Future<Device> update({@required Device device, @required Map<String, dynamic> patch}) async {
    String endpoint = '/devices/' + device.uuid.toString();
    String apiResponse = await provider.patchResponse(endpoint, jsonEncode(patch));
    return deviceFromJson(apiResponse);
  }

  Future<Response> logUpdate({@required Picture picture, int viewCount}) async {
    String _uuid = await Settings.getUuid();
    print(_uuid.toString());
    Map<String, dynamic> patch = {'category_id': picture.categoryId, 'last_view_picture_id': picture.id, 'view_count': viewCount};
    String endpoint = '/devices/' + _uuid + '/logs';
    String apiResponse = await provider.patchResponse(endpoint, jsonEncode(patch));
    return responseFromJson(apiResponse);
  }

  Future<Response> logUpdateViewCount({@required Picture picture}) async {
    String _uuid = await Settings.getUuid();
    print(_uuid.toString());
    String endpoint = '/devices/' + _uuid + '/logs/pictures/' + picture.id.toString() + '/update_view_count';
    String apiResponse = await provider.patchResponse(endpoint, '{}');
    return responseFromJson(apiResponse);
  }
}

library repositories;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/providers/shared_preferences_provider.dart';
import 'package:komik_seyler/business/util/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceRepository {
  final ApiProvider apiProvider;
  final SharedPreferencesProvider spp;

  DeviceRepository({spp, apiProvider})
      : spp = spp ?? SharedPreferencesProvider(),
        apiProvider = apiProvider ?? ApiProvider();

  Future<Device> get() async {
    Device _device;
    String _uuid = await Settings.getUuid();
    String endPoint = "/devices/" + _uuid;

    print("devices.get : " + endPoint);

    // _device = await _getFromLocal(); //Localden al.
    if (_device == null) {
      // Local yoksa karsidan iste
      String response = await apiProvider.get(endPoint);
      _device = deviceFromJson(response);
      spp.set('device', _device);
    }
    return _device;
  }

  Future<Device> _getFromLocal() async {
    Device _device;
    final SharedPreferences spp = await SharedPreferences.getInstance();

    String deviceString = spp.getString('device');
    if (deviceString != null && deviceString.length > 0) _device = deviceFromJson(deviceString);
    return _device ?? null;
  }

  Future<Device> store({@required Device device}) async {
    String endpoint = '/devices';
    String apiResponse = await apiProvider.post(endpoint, jsonEncode(device));
    return deviceFromJson(apiResponse);
  }

  Future<Device> update({@required Device device, @required Map<String, dynamic> patch}) async {
    String endpoint = '/devices/' + device.uuid;
    String apiResponse = await apiProvider.patch(endpoint, jsonEncode(patch));
    return deviceFromJson(apiResponse);
  }

  Future<Device> optionUpdate({@required Option option, @required Map<String, dynamic> patch}) async {
    String endpoint = '/devices/' + option.deviceUuid + '/options/' + option.id.toString();
    String apiResponse = await apiProvider.patch(endpoint, jsonEncode(patch));
    return deviceFromJson(apiResponse);
  }
}

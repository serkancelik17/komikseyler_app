import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/models/device.dart';
import 'package:komik_seyler/providers/api_provider.dart';

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

  Future<Device> store({@required String uuid}) async {
    String endpoint = '/devices/' + uuid + '/store';
    String apiResponse = await provider.getResponse(endpoint);
    return deviceFromJson(apiResponse);
  }
}
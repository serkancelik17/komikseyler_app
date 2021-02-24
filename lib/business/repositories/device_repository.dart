import 'package:komik_seyler/business/repositories/repository.dart';

class DeviceRepository extends Repository {
  DeviceRepository({apiProvider});

/*  Future<Device> get({bool viaLocal = true}) async {
    Device _device;
    String _uuid = await Settings.getUuid();
    String endPoint = "/devices/" + _uuid;

    print("devices.get : " + endPoint);
    if (viaLocal) _device = await _getFromLocal(); //Localden al.

    if (_device == null) {
      // Local yoksa karsidan iste
      PagelessResponse response = PagelessResponse.fromRawJson(await apiProvider.get(endPoint));
      _device = Device().fromJson(response.data[0]);
      SharedPreferencesProvider.set('device', _device);
    }
    return _device;
  }

  Future<Device> _getFromLocal() async {
    Device _device;

    String deviceString = await SharedPreferencesProvider.getString('device');
    if (deviceString != null && deviceString.length > 0) _device = Device.fromRawJson(deviceString);
    return _device ?? null;
  }*/
}

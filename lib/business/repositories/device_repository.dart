library repositories;

import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/providers/shared_preferences_provider.dart';
import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';
import 'package:komik_seyler/business/util/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceRepository extends ModelRepository {
  final SharedPreferencesProvider spp;

  DeviceRepository({spp, apiProvider})
      : spp = spp ?? SharedPreferencesProvider(),
        super(endPointPattern: '/devices');

  Future<Device> get({bool viaLocal = true}) async {
    Device _device;
    String _uuid = await Settings.getUuid();
    String endPoint = "/devices/" + _uuid;

    print("devices.get : " + endPoint);
    if (viaLocal) _device = await _getFromLocal(); //Localden al.

    if (_device == null) {
      // Local yoksa karsidan iste
      Response response = await apiProvider.get(endPoint);
      _device = Device.fromJson(response.data['device']);
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
}

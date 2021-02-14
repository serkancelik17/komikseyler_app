import 'package:komik_seyler/models/device.dart';
import 'package:komik_seyler/providers/api_provider.dart';
import 'package:komik_seyler/util/settings.dart';

class DeviceRepository {
  ApiProvider provider;

  DeviceRepository({this.provider}) {
    this.provider ??= ApiProvider();
  }

  Future<Device> get() async {
    String endPoint = "/devices/" + await Settings.getUuid();
    String response = await provider.getResponse(endPoint);
    Device _device = deviceFromJson(response);
    return _device;
  }
}

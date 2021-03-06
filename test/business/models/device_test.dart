import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/device.dart';
import 'package:komix/business/models/device/option.dart';

void main() {
  Device device = Device(
      id: 1,
      uuid: "xxx",
      note: "yyy",
      option: Option(deviceUuid: 'xxx', id: 2, adsShowAfter: null, isAdmin: 0));

  test("device.FromJson must be return Device", () {
    var actual = device.fromJson(device
        .toJson()); //TODO ayni classtan diger fonksiyonu kullanmadan çözülmesi gerekir.
    expect(actual, isA<Device>());
  });

  test("device.toJson must be return Map", () {
    var actual = device.toJson();
    expect(actual, isA<Map>());
  });

  test("device.toString must be return String", () {
    var actual = device.toString();
    expect(actual, isA<String>());
  });

  test("device.toRawJson must be return String", () {
    var actual = device.toRawJson();
    expect(actual, isA<String>());
  });
}

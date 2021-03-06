import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/device/log.dart';

void main() {
  Log log = Log(deviceUuid: 'xxx');

  test("log.FromJson must be return Log", () {
    var actual = log.fromJson({'device_uuid': 'xxx'});
    expect(actual, isA<Log>());
  });

  test("log.toJson must be return Map", () {
    var actual = log.toJson();
    expect(actual, isA<Map>());
  });

  test("log.toString must be return String", () {
    var actual = log.toString();
    expect(actual, isA<String>());
  });
}

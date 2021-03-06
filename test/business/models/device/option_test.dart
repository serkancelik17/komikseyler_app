import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/device/option.dart';

void main() {
  Option option = Option(deviceUuid: 'xxx');

  test("option.FromJson must be return Option", () {
    var actual = option.fromJson({'device_uuid': 'xxx'});
    expect(actual, isA<Option>());
  });

  test("option.toJson must be return Map", () {
    var actual = option.toJson();
    expect(actual, isA<Map>());
  });

  test("option.toString must be return String", () {
    var actual = option.toString();
    expect(actual, isA<String>());
  });
}

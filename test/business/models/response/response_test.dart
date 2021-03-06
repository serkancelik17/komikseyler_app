import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/response/response.dart';

void main() {
  Response response = Response();

  test("response.FromJson must be return Response", () {
    var actual = response.fromJson({});
    expect(actual, isA<Response>());
  });

  test("response.toJson must be return Map", () {
    var actual = response.toJson();
    expect(actual, isA<Map>());
  });

  test("response.toString must be return String", () {
    var actual = response.toString();
    expect(actual, isA<String>());
  });

  test("response.fromRawJson must be return Response", () {
    var actual = response.fromRawJson('{}');
    expect(actual, isA<Response>());
  });
}

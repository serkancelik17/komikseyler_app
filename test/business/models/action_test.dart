import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/action.dart';

void main() {
  Action action = Action();

  test("action.FromJson must be return Action", () {
    var actual = action.fromJson({});
    expect(actual, isA<Action>());
  });

  test("action.toJson must be return Map", () {
    var actual = action.toJson();
    expect(actual, isA<Map>());
  });

  test("action.toString must be return String", () {
    var actual = action.toString();
    expect(actual, isA<String>());
  });

  test("action.toRawJson must be return String", () {
    var actual = action.toRawJson();
    expect(actual, isA<String>());
  });
}

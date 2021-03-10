import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/action.dart';

void main() {
  Action action = Action(id: 1, name: "like", title: "Beğen");

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

  test("action.getTitle() must be return action.title", () {
    var actual = action.getTitle();
    expect(actual, action.title);
  });

  test("action.getPercent() must be return 0", () {
    var actual = action.getPercent();
    expect(actual, 0);
  });
}

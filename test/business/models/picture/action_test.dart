import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/picture/action.dart';

void main() {
  PictureAction pictureAction =
      PictureAction(deviceUuid: 'xxx', pictureId: 1, actionId: 5);

  test("pictureAction.FromJson must be return Action", () {
    var actual = pictureAction.fromJson(pictureAction.toJson());
    expect(actual, isA<PictureAction>());
  });

  test("pictureAction.toJson must be return Map", () {
    var actual = pictureAction.toJson();
    expect(actual, isA<Map>());
  });

  test("pictureAction.toString must be return String", () {
    var actual = pictureAction.toString();
    expect(actual, isA<String>());
  });
}

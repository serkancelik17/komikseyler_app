import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/picture.dart';
import 'package:komix/business/models/picture/action.dart';

void main() {
  PictureAction pictureAction = PictureAction(id: 1, deviceUuid: 'xxx', pictureId: 1, actionId: 1);
  Picture picture = Picture(id: 1, categoryId: 1, path: 'xxx/yyy', actions: [pictureAction], favoriteCount: 5, likeCount: 3, shareCount: 2);

  test("picture.FromJson must be return Action", () {
    var actual = picture.fromJson({});
    expect(actual, isA<Picture>());
  });

  test("picture.toJson must be return Map", () {
    var actual = picture.toJson();
    expect(actual, isA<Map>());
  });

  test("picture.toString must be return String", () {
    var actual = picture.toString();
    expect(actual, isA<String>());
  });

  test("picture.findPictureAction must be return Model", () {
    var actual = picture.findPictureAction(1);
    expect(actual, pictureAction);
  });

  test("picture.toRawJson must be return String", () {
    var actual = picture.toRawJson();
    expect(actual, isA<String>());
  });
}

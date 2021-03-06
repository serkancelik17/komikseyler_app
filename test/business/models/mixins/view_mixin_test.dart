import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/picture.dart';

void main() {
  Picture picture = Picture(
      id: 1,
      categoryId: 1,
      path: 'xxx/yyy',
      actions: [],
      favoriteCount: 5,
      likeCount: 3,
      shareCount: 2);

  test(".path must must be string", () {
    expect(picture.path, isA<String>());
  });
  test(".id must must be int", () {
    expect(picture.id, isA<int>());
  });
}

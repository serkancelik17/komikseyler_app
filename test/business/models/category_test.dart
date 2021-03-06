import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/category.dart';

void main() {
  Category category =
      Category(id: 1, name: 'Category Name', picturesCount: 100, viewCount: 50);

  test("category.FromJson must be return Action", () {
    var actual = category.fromJson({});
    expect(actual, isA<Category>());
  });

  test("category.toJson must be return Map", () {
    var actual = category.toJson();
    expect(actual, isA<Map>());
  });

  test("category.toString must be return String", () {
    var actual = category.toString();
    expect(actual, isA<String>());
  });

  test("category.toRawJson must be return String", () {
    var actual = category.toRawJson();
    expect(actual, isA<String>());
  });

  test("category.getTitle() must be return category.name", () {
    expect(category.getTitle(), category.name);
  });
  test("category.getId() must be return string", () {
    expect(category.getId(), category.id);
  });
  test("category.getUniqueName() must be return string", () {
    expect(category.getUniqueName(), 'category' + category.id.toString());
  });
  test("category.getPercent() must be return string", () {
    expect(category.getPercent(), 0.5);
  });
}

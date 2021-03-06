import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/category.dart';

void main() {
  Category category = Category(id: 1, name: "Karikatürler", viewCount: 50, picturesCount: 100);
  test("model.fromRawJson() must be return Model", () {
    var actual = category.fromRawJson(category.toRawJson());
    expect(actual, category);
  });
  test("model.find() must be return Model", () {});
  test("model.getEndPoint() must be return String", () {});
  test("model.setEndPoint() must be set endPoint and return Model", () {});
  test("model.where() must be return Model", () {});
  test("model.first() must be return Model", () {});
  test("model.get() must be return List<Model>", () {});
  test("model.store() must be return Model", () {});
  test("model.update() must be return true", () {});
  test("model.firstOrNew() must be return Model", () {});
  test("model.firstOrCreate() must be return Model", () {});
  test("model.updateOrCreate() must be return Model", () {});
  test("model.createFilters() must be return Map", () {});
  test("model.destroy() must be return true", () {});
}

import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/category.dart';
import 'package:komix/business/repositories/repository.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  Repository mockRepository = MockRepository();
  Category category = Category(
      id: 1,
      name: "Karikatürler",
      viewCount: 50,
      picturesCount: 100,
      repository: mockRepository);
  test("model.fromRawJson() must be return Model", () {
    var actual = category.fromRawJson(category.toRawJson());
    expect(actual, category);
  });
  test("model.find() must be return Model", () async {
    when(mockRepository.where(
      model: anyNamed("model"),
      parameters: anyNamed("parameters"),
      paginateType: anyNamed("paginateType"),
    )).thenAnswer((realInvocation) async => [category]);
    var actual = await category.find(id: 1);
    expect(actual, category);

    //var actual = category.fromRawJson(category.toRawJson());
    //expect(actual, category);
  });
  test("model.getEndPoint() must be return String", () {
    Category category = Category(
        id: 1,
        name: "Karikatürler",
        viewCount: 50,
        picturesCount: 100,
        repository: mockRepository);
    expect(category.getEndPoint(), "/categories");
  });
  test("model.setEndPoint() must be set endPoint and return Model", () {
    String newEndPoint = "/new_categories";
    category.setEndPoint(newEndPoint);
    expect(category.getEndPoint(), newEndPoint);
  });
  test("model.where() must be return Model and response is [Model]", () async {
    when(mockRepository.where(
      model: anyNamed("model"),
      parameters: anyNamed("parameters"),
      paginateType: anyNamed("paginateType"),
    )).thenAnswer((realInvocation) async => [category]);

    var actual = await category.where();
    expect(actual.response, [category]);
    expect(actual, category);
  });
  test("model.first() must be return Model", () {
    category.response = [category];
    var actual = category.first();
    expect(actual, category);
  });
  test("model.get() must be return List<Model>", () {
    category.response = [category];
    var actual = category.get();
    expect(actual, [category]);
  });
  test("model.store() must be return Model", () async {
    when(mockRepository.store(
      model: anyNamed("model"),
    )).thenAnswer((realInvocation) async => category);

    expect(await category.store(), category);
  });
  test("model.update() must be return true", () async {
    when(mockRepository.update(
      model: anyNamed("model"),
    )).thenAnswer((realInvocation) async => true);

    var actual = await category.update();

    expect(actual, true);
  });
  test("model.firstOrNew() must be return Model", () async {
    when(mockRepository.where(
      model: anyNamed("model"),
      parameters: anyNamed("parameters"),
      paginateType: anyNamed("paginateType"),
    )).thenAnswer((realInvocation) async => [category]);

    var actual = await category.firstOrNew({});

    expect(actual, category);
  });

  test("model.firstOrNew() must be return new Model", () async {
    when(mockRepository.where(
      model: anyNamed("model"),
      parameters: anyNamed("parameters"),
      paginateType: anyNamed("paginateType"),
    )).thenAnswer((realInvocation) async => [null]);

    var actual = await category.firstOrNew({});

    expect(actual, isA<Category>());
  });

  test("model.firstOrCreate() must be return Model", () async {
    when(mockRepository.where(
      model: anyNamed("model"),
      parameters: anyNamed("parameters"),
      paginateType: anyNamed("paginateType"),
    )).thenAnswer((realInvocation) async => [category]);

    var actual = await category.firstOrCreate({});
    expect(actual, category);
  });

/*
  test("when model is null model.firstOrCreate() must be return Model", () async {
    when(mockRepository.where(
      model: anyNamed("model"),
      parameters: anyNamed("parameters"),
      paginateType: anyNamed("paginateType"),
    )).thenAnswer((realInvocation) async => [null]);

    when(mockRepository.store(model: anyNamed("model"))).thenAnswer((realInvocation) async => category);

    var actual = await category.firstOrCreate({});
    expect(actual, category);
  });
*/

  test("given model and model.updateOrCreate() must be return Model", () async {
    when(mockRepository.where(
      model: anyNamed("model"),
      parameters: anyNamed("parameters"),
      paginateType: anyNamed("paginateType"),
    )).thenAnswer((realInvocation) async => [category]);

    //when(mockRepository.store(model: anyNamed("model"))).thenAnswer((realInvocation) async => category);

    var actual = await category.updateOrCreate({}, {});

    expect(actual, category);
  });

/*  test("given model is null and model.updateOrCreate() must be return Model", () async {

    when(mockRepository.store(model: anyNamed("model"))).thenAnswer((realInvocation) async => category);

    when(mockRepository.where(
      model: anyNamed("model"),
      parameters: anyNamed("parameters"),
      paginateType: anyNamed("paginateType"),
    )).thenAnswer((realInvocation) async => [null]);

    var actual = await category.updateOrCreate({}, {});

    expect(actual, category);
  });*/

  test("model.createFilters() must be return Map", () {
    expect(category.createFilters({"key": "value"}), {"filters[key]": "value"});
  });
  test("model.destroy() must be return true", () async {
    when(mockRepository.destroy(model: anyNamed("model")))
        .thenAnswer((realInvocation) async => true);

    var actual = await category.destroy();
    expect(actual, true);
  });
}

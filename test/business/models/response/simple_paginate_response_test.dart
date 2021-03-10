import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/response/response.dart';
import 'package:komix/business/models/response/simple_paginate_response.dart';

void main() {
  group("SimplePaginateResponse", () {
    SimplePaginateResponse simplePaginateResponse = SimplePaginateResponse(success: true, message: null, metaData: SimplePaginateMetaData());

    test("simplePaginateResponse.FromJson must be return Response", () {
      var actual = simplePaginateResponse.fromJson({});
      expect(actual, isA<Response>());
    });

    test("simplePaginateResponse.toJson must be return Map", () {
      var actual = simplePaginateResponse.toJson();
      expect(actual, isA<Map>());
    });

    test("simplePaginateResponse.toString must be return String", () {
      var actual = simplePaginateResponse.toString();
      expect(actual, isA<String>());
    });

    test("simplePaginateResponse.fromRawJson must be return Response", () {
      var actual = simplePaginateResponse.fromRawJson('{}');
      expect(actual, isA<Response>());
    });
  });

  group("SimplePaginateMetaData", () {
    SimplePaginateMetaData simplePaginateMetaData = SimplePaginateMetaData(
      to: 1,
      prevPageUrl: "x",
      perPage: "y",
      nextPageUrl: "z",
      from: 2,
      firstPageUrl: "a",
      currentPage: 3,
      data: [Data()],
      path: "b",
    );

    test("simplePaginateMetaData.FromJson must be return Response", () {
      var actual = simplePaginateMetaData.fromJson({});
      expect(actual, isA<SimplePaginateMetaData>());
    });

    test("simplePaginateMetaData.toJson must be return Map", () {
      var actual = simplePaginateMetaData.toJson();
      expect(actual, isA<Map>());
    });
  });

/*  group("Data", () {
    Data data = Data(
      path: "x",
      id: 1,
      categoryId: 2,
      favoritesCount: 3,
      likesCount: 4,
      sharesCount: 5,
      userFavoritesCount: 6,
      userLikesCount: 7,
      userSharesCount: 8,
    );
  });*/
}

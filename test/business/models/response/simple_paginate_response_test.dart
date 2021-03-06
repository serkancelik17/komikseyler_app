import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/response/response.dart';
import 'package:komix/business/models/response/simple_paginate_response.dart';

void main() {
  SimplePaginateResponse simplePaginateResponse = SimplePaginateResponse();

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
}

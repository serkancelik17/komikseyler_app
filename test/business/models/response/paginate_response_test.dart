import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/response/paginate_response.dart';
import 'package:komix/business/models/response/response.dart';

void main() {
  PaginateResponse paginateResponse = PaginateResponse();

  test("paginateResponse.FromJson must be return Response", () {
    var actual = paginateResponse.fromJson({});
    expect(actual, isA<Response>());
  });

  test("paginateResponse.toJson must be return Map", () {
    var actual = paginateResponse.toJson();
    expect(actual, isA<Map>());
  });

  test("paginateResponse.toString must be return String", () {
    var actual = paginateResponse.toString();
    expect(actual, isA<String>());
  });

  test("paginateResponse.fromRawJson must be return Response", () {
    var actual = paginateResponse.fromRawJson('{}');
    expect(actual, isA<Response>());
  });
}

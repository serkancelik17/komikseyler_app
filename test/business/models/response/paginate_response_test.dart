import 'package:flutter_test/flutter_test.dart';
import 'package:komix/business/models/response/paginate_response.dart';
import 'package:komix/business/models/response/response.dart';

void main() {
  Link link = Link(label: "link.label", active: true, url: "http://link.url");
  PaginateData paginateData = PaginateData(
    path: "/x",
    data: [],
    currentPage: 1,
    firstPageUrl: "http://x",
    from: 1,
    lastPage: 1,
    lastPageUrl: "http://y",
    links: [link],
    nextPageUrl: "http://z",
    perPage: "30",
    prevPageUrl: "http://a",
    to: 1,
    total: 1,
  );
  PaginateResponse paginateResponse = PaginateResponse(success: true, message: null, metaData: paginateData);

  test("paginateResponse.FromJson() must be return Response", () {
    var actual = paginateResponse.fromJson({});
    expect(actual, isA<Response>());
  });

  test("paginateResponse.toJson() must be return Map", () {
    var actual = paginateResponse.toJson();
    expect(actual, isA<Map>());
  });

  test("paginateResponse.toString() must be return String", () {
    var actual = paginateResponse.toString();
    expect(actual, isA<String>());
  });

  test("paginateResponse.fromRawJson() must be return Response", () {
    var actual = paginateResponse.fromRawJson('{}');
    expect(actual, isA<Response>());
  });

  //---- PaginateData ---/
  test("paginateData.FromJson() must be return PaginateData", () {
    var actual = paginateData.fromJson(paginateData.toJson());
    expect(actual, paginateData);
  });

  test("paginateData.toJson() must be return Map", () {
    var actual = paginateResponse.toJson();
    expect(actual, isA<Map>());
  });

  //---- Link ----/
  test("link.FromJson() must be return Link", () {
    var actual = link.fromJson(link.toJson());
    expect(actual, link);
  });

  test("link.toJson() must be return Map", () {
    var actual = link.toJson();
    expect(actual, isA<Map>());
  });
}

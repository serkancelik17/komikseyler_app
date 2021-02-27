// To parse this JSON data, do
//
//     final paginateResponse = paginateResponseFromJson(jsonString);
import 'dart:convert';

import 'package:komik_seyler/business/models/response/absctracts/response_meta_data_abstract.dart';
import 'package:komik_seyler/business/models/response/response.dart';

class PaginateResponse extends Response {
  PaginateResponse({
    success,
    metaData,
    message,
  }) : super(success: success, metaData: metaData, message: message);

  fromJson(Map<String, dynamic> json) => PaginateResponse(
        success: json["success"] == null ? null : json["success"],
        metaData: json["data"] == null ? null : PaginateData().fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class PaginateData extends ResponseMetaDataAbstract {
  PaginateData({
    this.currentPage,
    data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  }) : super(data: data);

  int currentPage;
  List<dynamic> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  String nextPageUrl;
  String path;
  String perPage;
  String prevPageUrl;
  int to;
  int total;

  PaginateResponse fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => PaginateData(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : json["data"],
        firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
        links: json["links"] == null ? null : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"] == null ? null : json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toString())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "links": links == null ? null : List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl == null ? null : prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String url;
  dynamic label;
  bool active;

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active == null ? null : active,
      };
}

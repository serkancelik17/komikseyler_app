// To parse this JSON data, do
//
//     final categoryPicture = categoryPictureFromJson(jsonString);

import 'dart:convert';

import 'package:komik_seyler/models/picture.dart';

CategoryPicture categoryPictureFromJson(String str) => CategoryPicture.fromJson(json.decode(str));

String categoryPictureToJson(CategoryPicture data) => json.encode(data.toJson());

class CategoryPicture {
  CategoryPicture({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  });

  int currentPage;
  List<Picture> data;
  String firstPageUrl;
  int from;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;

  factory CategoryPicture.fromJson(Map<String, dynamic> json) => CategoryPicture(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : List<Picture>.from(json["data"].map((x) => Picture.fromJson(x))),
        firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
      };
}

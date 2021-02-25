// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:komik_seyler/business/models/response/response.dart';

class SimplePaginateResponse extends Response {
  SimplePaginateResponse({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  SimplePaginateResponse fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  SimplePaginateResponse fromJson(Map<String, dynamic> json) => SimplePaginateResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        //"data": data == null ? null : List<dynamic>.from(data.map((x) => x.toString())),
        "message": message == null ? null : message,
      };
}

class Data {
  Data({
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
  List<dynamic> data;
  String firstPageUrl;
  int from;
  String nextPageUrl;
  String path;
  String perPage;
  dynamic prevPageUrl;
  int to;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : json['data'],
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
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toString())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
      };
}

class Datum {
  Datum({
    this.id,
    this.categoryId,
    this.path,
    this.likesCount,
    this.favoritesCount,
    this.sharesCount,
    this.userLikesCount,
    this.userFavoritesCount,
    this.userSharesCount,
  });

  int id;
  int categoryId;
  String path;
  int likesCount;
  int favoritesCount;
  int sharesCount;
  int userLikesCount;
  int userFavoritesCount;
  int userSharesCount;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        path: json["path"] == null ? null : json["path"],
        likesCount: json["likes_count"] == null ? null : json["likes_count"],
        favoritesCount: json["favorites_count"] == null ? null : json["favorites_count"],
        sharesCount: json["shares_count"] == null ? null : json["shares_count"],
        userLikesCount: json["user_likes_count"] == null ? null : json["user_likes_count"],
        userFavoritesCount: json["user_favorites_count"] == null ? null : json["user_favorites_count"],
        userSharesCount: json["user_shares_count"] == null ? null : json["user_shares_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "category_id": categoryId == null ? null : categoryId,
        "path": path == null ? null : path,
        "likes_count": likesCount == null ? null : likesCount,
        "favorites_count": favoritesCount == null ? null : favoritesCount,
        "shares_count": sharesCount == null ? null : sharesCount,
        "user_likes_count": userLikesCount == null ? null : userLikesCount,
        "user_favorites_count": userFavoritesCount == null ? null : userFavoritesCount,
        "user_shares_count": userSharesCount == null ? null : userSharesCount,
      };
}

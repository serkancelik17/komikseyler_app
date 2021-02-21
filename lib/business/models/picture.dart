// To parse this JSON data, do
//
//     final picture = pictureFromJson(jsonString);

import 'dart:convert';

import 'package:komik_seyler/business/models/abstracts/viewable.dart';

List<Picture> pictureFromJson(String str) => List<Picture>.from(json.decode(str).map((x) => Picture.fromJson(x)));

String pictureToJson(List<Picture> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Picture implements Viewable {
  Picture({
    id,
    this.categoryId,
    path,
    this.likesCount,
    this.favoritesCount,
    this.sharesCount,
    this.userLikesCount,
    this.userFavoritesCount,
    this.userSharesCount,
  })  : id = id ?? 0,
        path = path ?? '';

  int id;
  int categoryId;
  String path;
  int likesCount;
  int favoritesCount;
  int sharesCount;
  int userLikesCount;
  int userFavoritesCount;
  int userSharesCount;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        id: json["id"] == null ? null : json["id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        path: json["path"] == null ? null : json["path"],
        likesCount: json["likes_count"] == null ? 0 : json["likes_count"],
        favoritesCount: json["favorites_count"] == null ? 0 : json["favorites_count"],
        sharesCount: json["shares_count"] == null ? 0 : json["shares_count"],
        userLikesCount: json["user_likes_count"] == null ? 0 : json["user_likes_count"],
        userFavoritesCount: json["user_favorites_count"] == null ? 0 : json["user_favorites_count"],
        userSharesCount: json["user_shares_count"] == null ? 0 : json["user_shares_count"],
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

  @override
  String toString() {
    return 'Picture{id: $id, categoryId: $categoryId, path: $path, likesCount: $likesCount, favoritesCount: $favoritesCount, sharesCount: $sharesCount, userLikesCount: $userLikesCount, userFavoritesCount: $userFavoritesCount, userSharesCount: $userSharesCount}';
  }

  //-----------------------------------------------------------------------------------------------------//
}

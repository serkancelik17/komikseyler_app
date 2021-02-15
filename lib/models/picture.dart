// To parse this JSON data, do
//
//     final picture = pictureFromJson(jsonString);

import 'dart:convert';

import 'package:komik_seyler/models/abstracts/view_abstract.dart';

List<Picture> pictureFromJson(String str) => List<Picture>.from(json.decode(str).map((x) => Picture.fromJson(x)));

String pictureToJson(Picture data) => json.encode(data.toJson());

class Picture implements ViewAbstract {
  Picture({
    this.id,
    this.categoryId,
    this.path,
    this.likesCount,
    this.favoritesCount,
    this.userLikesCount,
    this.userFavoritesCount,
  });

  int id;
  int categoryId;
  String path;
  int likesCount;
  int favoritesCount;
  int userLikesCount;
  int userFavoritesCount;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        id: json["id"] == null ? null : json["id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        path: json["path"] == null ? null : json["path"],
        likesCount: json["likes_count"] == null ? null : json["likes_count"],
        favoritesCount: json["favorites_count"] == null ? null : json["favorites_count"],
        userLikesCount: json["user_likes_count"] == null ? null : json["user_likes_count"],
        userFavoritesCount: json["user_favorites_count"] == null ? null : json["user_favorites_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "category_id": categoryId == null ? null : categoryId,
        "path": path == null ? null : path,
        "likes_count": likesCount == null ? null : likesCount,
        "favorites_count": favoritesCount == null ? null : favoritesCount,
        "user_likes_count": userLikesCount == null ? null : userLikesCount,
        "user_favorites_count": userFavoritesCount == null ? null : userFavoritesCount,
      };

  @override
  String toString() {
    return 'Picture{id: $id, categoryId: $categoryId, path: $path, likesCount: $likesCount, favoritesCount: $favoritesCount, userLikesCount: $userLikesCount, userFavoritesCount: $userFavoritesCount}';
  }

  @override
  String getPath() {
    return this.path;
  }
}

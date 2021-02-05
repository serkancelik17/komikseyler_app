// To parse this JSON data, do
//
//     final picture = pictureFromJson(jsonString);

import 'dart:convert';

Picture pictureFromJson(String str) => Picture.fromJson(json.decode(str));

String pictureToJson(Picture data) => json.encode(data.toJson());

class Picture {
  Picture({
    this.id,
    this.categoryId,
    this.path,
    this.meLikesCount,
    this.meFavoritesCount,
    this.meHitsCount,
    this.meMovesCount,
    this.likesCount,
    this.favoritesCount,
    this.hitsCount,
    this.movesCount,
  });

  int id;
  int categoryId;
  String path;
  int meLikesCount;
  int meFavoritesCount;
  int meHitsCount;
  int meMovesCount;
  int likesCount;
  int favoritesCount;
  int hitsCount;
  int movesCount;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        id: json["id"] == null ? null : json["id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        path: json["path"] == null ? null : json["path"],
        meLikesCount: json["me_likes_count"] == null ? null : json["me_likes_count"],
        meFavoritesCount: json["me_favorites_count"] == null ? null : json["me_favorites_count"],
        meHitsCount: json["me_hits_count"] == null ? null : json["me_hits_count"],
        meMovesCount: json["me_moves_count"] == null ? null : json["me_moves_count"],
        likesCount: json["likes_count"] == null ? null : json["likes_count"],
        favoritesCount: json["favorites_count"] == null ? null : json["favorites_count"],
        hitsCount: json["hits_count"] == null ? null : json["hits_count"],
        movesCount: json["moves_count"] == null ? null : json["moves_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "category_id": categoryId == null ? null : categoryId,
        "path": path == null ? null : path,
        "me_likes_count": meLikesCount == null ? null : meLikesCount,
        "me_favorites_count": meFavoritesCount == null ? null : meFavoritesCount,
        "me_hits_count": meHitsCount == null ? null : meHitsCount,
        "me_moves_count": meMovesCount == null ? null : meMovesCount,
        "likes_count": likesCount == null ? null : likesCount,
        "favorites_count": favoritesCount == null ? null : favoritesCount,
        "hits_count": hitsCount == null ? null : hitsCount,
        "moves_count": movesCount == null ? null : movesCount,
      };
}

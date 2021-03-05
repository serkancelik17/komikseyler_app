// To parse this JSON data, do
//
//     final picture = pictureFromJson(jsonString);

import 'package:komix/business/models/mixins/view_mixin.dart';
import 'package:komix/business/models/model.dart';
import 'package:komix/business/models/picture/action.dart';
import 'package:komix/business/models/response/response.dart';

class Picture extends Model with ViewMixin {
  Picture({
    this.id,
    this.categoryId,
    this.path,
    this.likeCount,
    this.favoriteCount,
    this.shareCount,
    this.actions,
  }) : super(uniqueId: id, endPoint: '/pictures', paginateType: PaginateType.simple);

  int id;
  int categoryId;
  String path;
  int likeCount;
  int favoriteCount;
  int shareCount;
  List<PictureAction> actions;

  Picture fromJson(Map<String, dynamic> json) => Picture(
        id: json["id"] == null ? null : json["id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        path: json["path"] == null ? null : json["path"],
        likeCount: json["like_count"] == null ? null : json["like_count"],
        favoriteCount: json["favorite_count"] == null ? null : json["favorite_count"],
        shareCount: json["share_count"] == null ? null : json["share_count"],
        actions: json["actions"] == null ? null : List<PictureAction>.from(json["actions"].map((x) => PictureAction(deviceUuid: 'x', pictureId: 0).fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "category_id": categoryId == null ? null : categoryId,
        "path": path == null ? null : path,
        "like_count": likeCount == null ? null : likeCount,
        "favorite_count": favoriteCount == null ? null : favoriteCount,
        "share_count": shareCount == null ? null : shareCount,
        "actions": actions == null ? null : List<dynamic>.from(actions.map((x) => x.toJson())),
      };

  Model findPictureAction(int actionId) {
    Model _model;
    if (actions != null)
      _model = actions.firstWhere((element) => element.actionId == actionId, orElse: () {
        return null;
      });
    return _model;
  }
}

// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/models/response/response.dart';

class Category extends Model with SectionMixin {
  Category({
    this.id,
    this.name,
    this.picturesCount,
    this.viewCount,
  }) : super(endPoint: "/categories", uniqueId: id, paginateType: PaginateType.simple);

  int id;
  String name;
  int picturesCount;
  int viewCount;

  @override
  fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        picturesCount: json["pictures_count"] == null ? null : json["pictures_count"],
        viewCount: json["view_count"] == null ? null : json["view_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "pictures_count": picturesCount == null ? null : picturesCount,
        "view_count": viewCount == null ? null : viewCount,
      };

  // ---- //
  @override
  String getTitle() {
    return this.name;
  }

  @override
  int getId() {
    return this.id;
  }

  @override
  String getUniqueName() {
    return 'category' + this.getId().toString();
  }

  @override
  double getPercent() {
    return this.viewCount / this.picturesCount;
  }

  @override
  bool calculatePercent() {
    return false;
  }

  @override
  SectionMixin setViewCount(int viewCount) {
    this.viewCount = viewCount;
    return this;
  }

  String toRawJson() {
    return null;
  }
}

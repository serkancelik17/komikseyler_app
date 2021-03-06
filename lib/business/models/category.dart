// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:komix/business/models/mixins/section_mixin.dart';
import 'package:komix/business/models/model.dart';
import 'package:komix/business/models/response/response.dart';

class Category extends Model with SectionMixin, EquatableMixin {
  Category({
    this.id,
    this.name,
    this.picturesCount,
    this.viewCount,
    repository,
  }) : super(endPoint: "/categories", uniqueId: id, paginateType: PaginateType.simple, repository: repository ?? null);

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
  String toString() {
    return 'Category{id: $id, name: $name, picturesCount: $picturesCount, viewCount: $viewCount}';
  }

  @override
  // TODO: implement props
  List<Object> get props => ['id', 'name', 'picturesCount', 'viewCount'];
}

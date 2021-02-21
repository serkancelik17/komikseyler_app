// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/repositories/abstracts/repository_mixin.dart';
import 'package:komik_seyler/business/repositories/category_repository.dart';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category extends Model with SectionMixin {
  Category({
    this.id,
    this.name,
    this.picturesCount,
    this.viewCount,
  }) : super(repository: CategoryRepository(), endPoint: "/devices/{{device_uuid}}/categories", uniqueId: id);

  int id;
  String name;
  int picturesCount;
  int viewCount;

  @override
  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
  RepositoryMixin getRepository() {
    return new CategoryRepository();
  }

  @override
  int getId() {
    return this.id;
  }

  @override
  String getUniqueName() {
    // TODO: implement getName
    return 'category' + this.getId().toString();
  }

  @override
  double getPercent() {
    return this.viewCount / this.picturesCount;
  }

  @override
  bool calculatePercent() {
    // TODO: implement calculatePercent
    throw UnimplementedError();
  }

  @override
  SectionMixin setViewCount(int viewCount) {
    this.viewCount = viewCount;
    return this;
  }
}

// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/repositories/abstracts/repository_abstract.dart';
import 'package:komik_seyler/business/repositories/category_repository.dart';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category extends SectionAbstract {
  Category({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };

  @override
  String getTitle() {
    return this.name;
  }

  @override
  RepositoryAbstract getRepository() {
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
}

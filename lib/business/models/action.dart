// To parse this JSON data, do
//
//     final action = actionFromJson(jsonString);

import 'dart:convert';

import 'package:komik_seyler/business/models/abstracts/sectionable.dart';
import 'package:komik_seyler/business/repositories/abstracts/repositoriable.dart';
import 'package:komik_seyler/business/repositories/action_repository.dart';

Action actionFromJson(String str) => Action.fromJson(json.decode(str));

String actionToJson(Action data) => json.encode(data.toJson());

class Action extends Sectionable {
  Action({
    this.id,
    this.name,
    this.title,
  });

  int id;
  String name;
  String title;

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "title": title == null ? null : title,
      };

  @override
  String getTitle() {
    return this.title;
  }

  @override
  Repositoriable getRepository() {
    return new ActionRepository();
  }

  @override
  int getId() {
    return this.id;
  }

  @override
  String getUniqueName() {
    return 'action' + this.getId().toString();
  }

  @override
  double getPercent() {
    return 0;
  }

  @override
  bool calculatePercent() {
    return false;
  }

  @override
  Sectionable setViewCount(int viewCount) {
    return this;
  }
}

// To parse this JSON data, do
//
//     final action = actionFromJson(jsonString);

import 'dart:convert';

Action actionFromJson(String str) => Action.fromJson(json.decode(str));

String actionToJson(Action data) => json.encode(data.toJson());

class Action {
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
}
import 'dart:convert';

mixin JsonAbleData {
  fromRawJson(String str) => fromJson(json.decode(str));
  fromJson(Map<String, dynamic> json);
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson();
}

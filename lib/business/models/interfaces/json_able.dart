import 'dart:convert';

import 'package:komix/business/models/model.dart';

abstract class JsonAble {
  Model fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  Model fromRawJson(String str);
  String toRawJson() => json.encode(toJson());

  // String toRawJson();
}

// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);
import 'dart:convert';

import 'package:komik_seyler/business/models/response/response.dart';

class GetResponse extends Response {
  bool success;
  List<dynamic> data;
  String message;

  GetResponse({
    this.success,
    this.data,
    this.message,
  });

  GetResponse fromJson(Map<String, dynamic> json) {
    GetResponse _pagelessResponse = GetResponse(
      success: json["success"] == null ? null : json["success"],
      data: json["data"] == null ? null : json['data'],
      message: json["message"] == null ? null : json["message"],
    );
    return _pagelessResponse;
  }

  GetResponse fromRawJson(String str) {
    Map jsonData = json.decode(str);
    return fromJson(jsonData);
  }
}

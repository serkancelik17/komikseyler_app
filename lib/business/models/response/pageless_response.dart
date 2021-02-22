// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

class PagelessResponse {
  PagelessResponse({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  List<dynamic> data;
  String message;

  factory PagelessResponse.fromRawJson(String str) => PagelessResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PagelessResponse.fromJson(Map<String, dynamic> json) => PagelessResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : json["data"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toString())),
        "message": message == null ? null : message,
      };
}

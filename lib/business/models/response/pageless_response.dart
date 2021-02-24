// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);
import 'dart:convert';

class PagelessResponse {
  bool success;
  List<dynamic> data;
  String message;

  PagelessResponse({
    this.success,
    this.data,
    this.message,
  });

  PagelessResponse fromJson(Map<String, dynamic> json) {
    PagelessResponse _pagelessResponse = PagelessResponse(
      success: json["success"] == null ? null : json["success"],
      data: json["data"] == null ? null : json['data'],
      message: json["message"] == null ? null : json["message"],
    );
    return _pagelessResponse;
  }

  PagelessResponse fromRawJson(String str) {
    Map jsonData = json.decode(str);
    return fromJson(jsonData);
  }
}

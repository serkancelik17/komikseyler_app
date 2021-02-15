// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  List data;
  dynamic message;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        success: json["success"] == null ? null : json["success"],
        data:
            json["data"] == null ? null : List.from(json["data"].map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

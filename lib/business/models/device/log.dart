// To parse this JSON data, do
//
//     final log = logFromJson(jsonString);

import 'dart:convert';

Log logFromJson(String str) => Log.fromJson(json.decode(str));

String logToJson(Log data) => json.encode(data.toJson());

class Log {
  Log({
    this.id,
    this.deviceUuid,
    this.categoryId,
    this.lastViewPictureId,
    this.viewCount,
  });

  int id;
  String deviceUuid;
  int categoryId;
  int lastViewPictureId;
  int viewCount;

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        id: json["id"] == null ? null : json["id"],
        deviceUuid: json["device_uuid"] == null ? null : json["device_uuid"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        lastViewPictureId: json["last_view_picture_id"] == null ? null : json["last_view_picture_id"],
        viewCount: json["view_count"] == null ? null : json["view_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "device_uuid": deviceUuid == null ? null : deviceUuid,
        "category_id": categoryId == null ? null : categoryId,
        "last_view_picture_id": lastViewPictureId == null ? null : lastViewPictureId,
        "view_count": viewCount == null ? null : viewCount,
      };
}

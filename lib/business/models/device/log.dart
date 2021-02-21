// To parse this JSON data, do
//
//     final log = logFromJson(jsonString);

import 'dart:convert';

import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/repositories/device/log_repository.dart';

List<Log> logFromJson(String str) => List<Log>.from(json.decode(str).map((x) => Log.fromJson(x)));

String logToJson(List<Log> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Log extends Model {
  Log({this.id, this.deviceUuid, this.categoryId, this.lastViewPictureId, this.viewCount})
      : super(
          repository: LogRepository(),
          endPoint: '/devices/{{device_uuid}}/logs',
          uniqueId: id ?? 0,
        );

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

// To parse this JSON data, do
//
//     final log = logFromJson(jsonString);

import 'dart:convert';

import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/repositories/device/log_repository.dart';

class Log extends Model {
  int id;
  String deviceUuid;
  int categoryId;
  int lastViewPictureId;
  int viewCount;

  Log({this.id, this.deviceUuid, this.categoryId, this.lastViewPictureId, this.viewCount}) : super(repository: LogRepository(), uniqueId: id, endPoint: '/device_logs');

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => Log(
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

  @override
  String toString() {
    return 'Log{id: $id, deviceUuid: $deviceUuid, categoryId: $categoryId, lastViewPictureId: $lastViewPictureId, viewCount: $viewCount}';
  }
}

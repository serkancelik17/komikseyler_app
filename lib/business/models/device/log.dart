// To parse this JSON data, do
//
//     final log = logFromJson(jsonString);

import 'dart:convert';

import 'package:komix/business/models/model.dart';
import 'package:komix/business/models/response/response.dart';

class Log extends Model {
  Log({
    this.id,
    this.deviceUuid,
    this.categoryId,
    this.lastViewPictureId,
  }) : super(endPoint: '/device_logs', uniqueId: id, paginateType: PaginateType.none);

  int id;
  String deviceUuid;
  int categoryId;
  int lastViewPictureId;

  Log fromRawJson(String str) => fromJson(json.decode(str));

  Log fromJson(Map<String, dynamic> json) => Log(
        id: json["id"] == null ? null : json["id"],
        deviceUuid: json["device_uuid"] == null ? null : json["device_uuid"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        lastViewPictureId: json["last_view_picture_id"] == null ? null : json["last_view_picture_id"],
      );
  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "device_uuid": deviceUuid == null ? null : deviceUuid,
        "category_id": categoryId == null ? null : categoryId,
        "last_view_picture_id": lastViewPictureId == null ? null : lastViewPictureId,
      };

  @override
  String toString() {
    return 'Log{categoryId: $categoryId}';
  }
}

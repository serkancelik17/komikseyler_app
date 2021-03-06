// To parse this JSON data, do
//
//     final log = logFromJson(jsonString);

import 'package:flutter/material.dart';
import 'package:komix/business/models/model.dart';
import 'package:komix/business/models/response/response.dart';

class Log extends Model {
  Log({
    this.id,
    @required this.deviceUuid,
    this.categoryId,
    this.lastViewPictureId,
    this.viewCount,
  }) : super(
            endPoint: '/devices/' + deviceUuid + '/logs',
            uniqueId: id,
            paginateType: PaginateType.none);

  int id;
  String deviceUuid;
  int categoryId;
  int lastViewPictureId;
  int viewCount;

  Log fromJson(Map<String, dynamic> json) => Log(
        id: json["id"] == null ? null : json["id"],
        deviceUuid: json["device_uuid"] == null ? null : json["device_uuid"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        lastViewPictureId: json["last_view_picture_id"] == null
            ? null
            : json["last_view_picture_id"],
        viewCount: json["view_count"] == null ? 0 : json["view_count"],
      );
  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "device_uuid": deviceUuid == null ? null : deviceUuid,
        "category_id": categoryId == null ? null : categoryId,
        "last_view_picture_id":
            lastViewPictureId == null ? null : lastViewPictureId,
        "view_count": viewCount == null ? 0 : viewCount,
      };

  @override
  String toString() {
    return 'Log{id: $id, deviceUuid: $deviceUuid, categoryId: $categoryId, lastViewPictureId: $lastViewPictureId, viewCount: $viewCount}';
  }
}

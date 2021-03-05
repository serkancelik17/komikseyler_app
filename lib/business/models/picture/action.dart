// To parse this JSON data, do
//
//     final pictureAction = pictureActionFromJson(jsonString);

import 'package:flutter/cupertino.dart';
import 'package:komix/business/models/model.dart';

class PictureAction extends Model {
  int id;
  @required
  String deviceUuid;
  @required
  int pictureId;
  int actionId;

  PictureAction({
    this.id,
    this.deviceUuid,
    this.pictureId,
    this.actionId,
  }) : super(endPoint: "/devices/" + deviceUuid + "/pictures/" + pictureId.toString() + "/actions", uniqueId: id);

  PictureAction fromJson(Map<String, dynamic> json) => PictureAction(
        id: json["id"] == null ? null : json["id"],
        deviceUuid: json["device_uuid"] == null ? null : json["device_uuid"],
        pictureId: json["picture_id"] == null ? null : json["picture_id"],
        actionId: json["action_id"] == null ? null : json["action_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "device_uuid": deviceUuid == null ? null : deviceUuid,
        "picture_id": pictureId == null ? null : pictureId,
        "action_id": actionId == null ? null : actionId,
      };
}

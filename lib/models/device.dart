// To parse this JSON data, do
//
//     final device = deviceFromJson(jsonString);

import 'dart:convert';

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());

class Device {
  Device({
    this.id,
    this.uuid,
    this.isAdmin,
    this.note,
    this.showAd,
  });

  int id;
  String uuid;
  int isAdmin;
  dynamic note;
  int showAd;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"] == null ? null : json["id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        isAdmin: json["is_admin"] == null ? 0 : json["is_admin"],
        note: json["note"],
        showAd: json["show_ad"] == null ? 1 : json["show_ad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uuid": uuid == null ? null : uuid,
        "is_admin": isAdmin == null ? 0 : isAdmin,
        "note": note,
        "show_ad": showAd == null ? 1 : showAd,
      };
}

// To parse this JSON data, do
//
//     final device = deviceFromJson(jsonString);

import 'dart:convert';

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());

class Device {
  Device({
    this.id,
    this.deviceId,
    this.isAdmin,
    this.note,
  });

  int id;
  String deviceId;
  int isAdmin;
  dynamic note;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"] == null ? null : json["id"],
        deviceId: json["device_id"] == null ? null : json["device_id"],
        isAdmin: json["is_admin"] == null ? null : json["is_admin"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "device_id": deviceId == null ? null : deviceId,
        "is_admin": isAdmin == null ? null : isAdmin,
        "note": note,
      };
}

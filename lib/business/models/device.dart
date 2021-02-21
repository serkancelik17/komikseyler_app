// To parse this JSON data, do
//
//     final device = deviceFromJson(jsonString);

import 'dart:convert';

import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());

class Device with Model {
  final DeviceRepository deviceRepository;

  Device({this.id, this.uuid, this.note, this.option, deviceRepository}) : deviceRepository = deviceRepository ?? DeviceRepository();

  int id;
  String uuid;
  dynamic note;
  Option option;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"] == null ? null : json["id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        note: json["note"],
        option: json["option"] == null ? null : Option.fromJson(json["option"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uuid": uuid == null ? null : uuid,
        "note": note,
        "option": option == null ? null : option.toJson(),
      };
}

class Option {
  Option({
    this.id,
    this.deviceUuid,
    this.isAdmin = 0,
    this.adsShowAfter,
  });

  int id;
  String deviceUuid;
  int isAdmin;
  DateTime adsShowAfter;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"] == null ? null : json["id"],
        deviceUuid: json["device_uuid"] == null ? null : json["device_uuid"],
        isAdmin: json["is_admin"] == null ? null : json["is_admin"],
        adsShowAfter: json["ads_show_after"] == null ? null : DateTime.parse(json["ads_show_after"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "device_uuid": deviceUuid == null ? null : deviceUuid,
        "is_admin": isAdmin == null ? null : isAdmin,
        "ads_show_after": adsShowAfter == null ? null : adsShowAfter.toIso8601String(),
      };
}

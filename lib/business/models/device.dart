// To parse this JSON data, do
//
//     final device = deviceFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/business/models/device/option.dart';
import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());

class Device extends Model {
  int id;
  String uuid;
  dynamic note;
  Option option;

  Device({this.id, @required this.uuid, this.note, this.option}) : super(repository: DeviceRepository(), endPoint: '/devices', uniqueId: uuid);

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

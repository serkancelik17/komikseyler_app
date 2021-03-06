// To parse this JSON data, do
//
//     final device = deviceFromJson(jsonString);

import 'dart:convert';

import 'package:komix/business/models/device/option.dart';
import 'package:komix/business/models/model.dart';
import 'package:komix/business/models/response/response.dart';

class Device extends Model {
  int id;
  String uuid;
  dynamic note;
  Option option;

  Device({this.id, this.uuid, this.note, this.option}) : super(uniqueId: uuid, endPoint: '/devices', paginateType: PaginateType.simple);

  //---
  factory Device.fromRawJson(String str) => Device().fromJson(json.decode(str));

  fromJson(Map<String, dynamic> json) => Device(
        id: json["id"] == null ? null : json["id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        note: json["note"],
        option: json["option"] == null ? new Option(deviceUuid: json['uuid']) : Option(deviceUuid: json['uuid']).fromJson(json["option"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uuid": uuid == null ? null : uuid,
        "note": note,
        "option": option == null ? null : option.toJson(),
      };
}

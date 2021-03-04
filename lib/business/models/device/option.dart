import 'dart:convert';

import 'package:komix/business/models/model.dart';
import 'package:komix/business/models/response/response.dart';
import 'package:komix/business/repositories/device/option_repository.dart';

class Option extends Model {
  Option({
    this.id,
    this.deviceUuid,
    this.isAdmin,
    this.adsShowAfter,
  }) : super(endPoint: '/device_options', repository: OptionRepository(), uniqueId: id, paginateType: PaginateType.none);

  int id;
  String deviceUuid;
  int isAdmin;
  DateTime adsShowAfter;

  factory Option.fromRawJson(String str) => Option().fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Option fromJson(Map<String, dynamic> json) => Option(
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

import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/repositories/device/option_repository.dart';

class Option extends Model {
  Option({
    this.id,
    this.deviceUuid,
    this.isAdmin = 0,
    this.adsShowAfter,
  }) : super(repository: OptionRepository(), tableName: 'device_logs', uniqueId: id);

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

  @override
  // TODO: implement tableName
  String get tableName => 'device_options';
}

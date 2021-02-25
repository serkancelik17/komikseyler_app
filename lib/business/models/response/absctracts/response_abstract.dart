import 'dart:convert';

import 'package:komik_seyler/business/models/response/absctracts/response_meta_data_abstract.dart';

abstract class ResponseDataAbstract {
  bool success;
  ResponseMetaDataAbstract metaData;
  String message;

  ResponseDataAbstract({this.success, this.metaData, this.message});

  fromJson(Map<String, dynamic> json);
  ResponseDataAbstract fromRawJson(String str) => fromJson(json.decode(str));
  String toRawJson() => json.encode(this.toJson());

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        //"data": data == null ? null : Data.map((x) => x.toString())),
        "message": message == null ? null : message,
      };
}

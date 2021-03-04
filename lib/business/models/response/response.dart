// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);
import 'dart:convert';

import 'package:komix/business/models/response/absctracts/response_meta_data_abstract.dart';

class Response {
  bool success;
  ResponseMetaDataAbstract metaData;
  String message;

  Response({
    this.success,
    this.metaData,
    this.message,
  });

  Response fromJson(Map<String, dynamic> json) {
    Response _pagelessResponse = Response(
      success: json["success"] == null ? null : json["success"],
      metaData: json["data"] == null ? null : GetMetaData(data: json['data']),
      message: json["message"] == null ? null : json["message"],
    );
    return _pagelessResponse;
  }

  Response fromRawJson(String str) {
    Map jsonData = json.decode(str);
    return fromJson(jsonData);
  }
}

class GetMetaData extends ResponseMetaDataAbstract {
  GetMetaData({data}) : super(data: data);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

enum PaginateType {
  none,
  simple,
  paginate,
}

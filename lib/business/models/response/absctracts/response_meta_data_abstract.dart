import 'dart:convert';

abstract class ResponseMetaDataAbstract {
  List<dynamic> data;

  ResponseMetaDataAbstract({this.data});
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson();
}

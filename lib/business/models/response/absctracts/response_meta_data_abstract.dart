abstract class ResponseMetaDataAbstract {
  List<dynamic> data;

  ResponseMetaDataAbstract({this.data});
  Map<String, dynamic> toJson();
}

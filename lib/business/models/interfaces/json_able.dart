import 'package:komik_seyler/business/models/model.dart';

abstract class JsonAble {
  Model fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  Model fromRawJson(String str);

  // String toRawJson();
}

import 'package:komix/business/models/mixins/view_mixin.dart';
import 'package:komix/business/models/model.dart';

class Ad extends Model implements ViewMixin {
  @override
  String get path {
    return '';
  }

  @override
  int get id {
    return 0;
  }

  @override
  Model fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

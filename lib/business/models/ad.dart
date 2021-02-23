import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/business/models/model.dart';

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
    return null;
  }

  @override
  Map<String, dynamic> toJson() {
    return null;
  }
}

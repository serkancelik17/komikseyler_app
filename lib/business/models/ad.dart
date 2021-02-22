import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/business/models/model.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';

class Ad extends Model implements ViewMixin {
  Ad() : super(endPoint: '', repository: DeviceRepository(), uniqueId: '/ads'); //@TODO repositopry farklı disable edilmesi lazım.

  @override
  String get path {
    return '';
  }

  @override
  int get id {
    // TODO: implement getId
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

import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/mixins/has_attributes_mixin.dart';
import 'package:komik_seyler/business/models/mixins/has_global_scopes_mixin.dart';
import 'package:komik_seyler/business/models/mixins/json_able_mixin.dart';
import 'package:komik_seyler/business/models/mixins/json_serializable_mixin.dart';
import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';

abstract class Model with HasGlobalScopesMixin, HasAttributesMixin, JsonAbleMixin, JsonSerializableMixin {
  dynamic uniqueId;
  static ModelRepository repository;
  String endPoint;
  Device device;

  Model({@required repository, @required this.endPoint, @required dynamic uniqueId})
      : uniqueId = uniqueId ?? 0,
        assert(repository != null),
        assert(endPoint != null) {
    Model.repository = repository;
  }

  //Model find(dynamic id) => this;

  Future<String> getEndPoint() async {
    if (device == null) device = await DeviceRepository().get();

    endPoint = endPoint.replaceAll("{{device_uuid}}", device.uuid);
    return this.endPoint;
  }
}

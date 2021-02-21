import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/device/option.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';

abstract class Model {
  dynamic uniqueId;
  ModelRepository repository;
  String endPoint;
  Device device;

  Model({@required this.repository, @required this.endPoint, @required dynamic uniqueId})
      : uniqueId = uniqueId ?? 0,
        assert(repository != null),
        assert(endPoint != null);

  //Model find(dynamic id) => this;

  Future<bool> store() async {
    Response response = await this.repository.store(model: this);
    return response.success;
  }

  Future<Model> update() async {
    Response response = await this.repository.update(model: this);
    return Option.fromJson(response.data[0]);
  }

  Future<bool> destroy() async {
    Response response = await this.repository.destroy(model: this);
    return response.success;
  }

  Future<Map<String, dynamic>> where({Map<String, dynamic> filter}) async {
    Response response = await this.repository.where(model: this, filter: filter);
    return response.data[0];
  }

  Future<String> getEndPoint() async {
    if (device == null) device = await DeviceRepository().get();

    endPoint = endPoint.replaceAll("{{device_uuid}}", device.uuid);
    return this.endPoint;
  }

  Map<String, dynamic> toJson();
}

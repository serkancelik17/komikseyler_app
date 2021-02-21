import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/device/log.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';

class LogRepository {
  final ApiProvider apiProvider;

  LogRepository({apiProvider}) : apiProvider = apiProvider ?? ApiProvider();

  Future<Log> get(Device _device, SectionAbstract _section) async {
    Log _log = new Log();
    String endPoint = "/devices/" + _device.uuid + "/logs?filter[category_id]=" + _section.getId().toString();

    Response response = responseFromJson(await apiProvider.get(endPoint));
    _log = logFromJson(response.data['logs'][0]);
    return _log;
  }

  Future<Response> update({@required Log log}) async {
    String endpoint = '/devices/' + log.deviceUuid + '/logs/' + log.id.toString();
    String apiResponse = await apiProvider.patch(endpoint, jsonEncode(log));
    return responseFromJson(apiResponse);
  }
}

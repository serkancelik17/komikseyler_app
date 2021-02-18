import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/business/models/action.dart' as Local;
import 'package:komik_seyler/business/models/device.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/providers/provider.dart';
import 'package:komik_seyler/business/util/settings.dart';

class PictureRepository {
  Provider _provider;

  PictureRepository([this._provider]) {
    this._provider ??= ApiProvider();
  }

  Future<Response> destroy({@required pictureId}) async {
    String endpoint = '/pictures/' + pictureId.toString() + '/destroy';
    Response response = responseFromJson(await _provider.getResponse(endpoint));
    return response;
  }

  Future<Response> addAction({@required Local.Action action, @required Picture picture, bool value = true}) async {
    Device _device = await Settings.getDevice();
    String endpoint = '/devices/' + _device.uuid + '/pictures/' + picture.id.toString() + '/actions/' + action.id.toString() + '/' + (value ? 'store' : 'destroy');
    try {
      Response response = responseFromJson(await _provider.getResponse(endpoint));

      return response;
    } catch (e) {
      throw e;
    }
  }
}

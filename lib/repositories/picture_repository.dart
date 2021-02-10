import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/models/response.dart';
import 'package:komik_seyler/providers/api_provider.dart';
import 'package:komik_seyler/providers/provider.dart';
import 'package:komik_seyler/util/settings.dart';

class PictureRepository {
  Provider _provider;

  PictureRepository([this._provider]) {
    this._provider ??= ApiProvider();
  }

  Future<bool> destroy({@required pictureId}) async {
    String endpoint = '/pictures/' + pictureId.toString() + '/destroy';
    try {
      Response response = responseFromJson(await _provider.getResponse(endpoint));
      return response.success;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> addAction({@required actionName, @required int pictureId, bool value = true}) async {
    String endpoint = '/devices/' + await Settings.getUuid() + '/pictures/' + pictureId.toString() + '/actions/' + actionName + '/' + (value ? 'store' : 'destroy');
    try {
      Response response = responseFromJson(await _provider.getResponse(endpoint));

      return response;
    } catch (e) {
      throw e;
    }
  }
}

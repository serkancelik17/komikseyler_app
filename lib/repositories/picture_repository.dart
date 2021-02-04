import 'package:client_information/client_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/models/response.dart';
import 'package:komik_seyler/providers/api_provider.dart';
import 'package:komik_seyler/providers/provider.dart';

class PictureRepository {
  Provider _provider;

  PictureRepository([this._provider]) {
    this._provider ??= ApiProvider();
  }

  Future<bool> destroy({@required pictureId}) async {
    String endpoint = '/devices/' + await getDeviceId() + '/pictures/' + pictureId.toString() + '/destroy';
    try {
      Response response = responseFromJson(await _provider.getResponse(endpoint));
    } catch (e) {
      throw e;
    }
  }

  Future<Response> addAction({@required actionName, @required int pictureId, bool value = true}) async {
    String endpoint = '/devices/' + await getDeviceId() + '/pictures/' + pictureId.toString() + '/actions/' + actionName + '/' + (value ? 'store' : 'destroy');
    try {
      Response response = responseFromJson(await _provider.getResponse(endpoint));

      return response;
    } catch (e) {
      throw e;
    }
  }

  /// Support on iOS, Android and web project
  Future<String> getDeviceId() async {
    return (await ClientInformation.fetch()).deviceId;
  }
}

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
    String endpoint = '/pictures/' + pictureId.toString() + '/destroy';
    try {
      String response = await _provider.getResponse(endpoint);
    } catch (e) {
      throw e;
    }
  }

  Future<bool> addAction({@required actionName, @required int pictureId, bool value = true}) async {
    String deviceId = await getDeviceId();

    String endpoint = '/' + deviceId + '/pictures/' + pictureId.toString() + '/actions/' + actionName + '/' + (value ? 'store' : 'destroy');
    try {
      String response = await _provider.getResponse(endpoint);
      Response responseJson = responseFromJson(response);
      if (responseJson.success == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }

  /// Support on iOS, Android and web project
  Future<String> getDeviceId() async {
    return (await ClientInformation.fetch()).deviceId;
  }
}

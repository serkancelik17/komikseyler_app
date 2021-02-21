import 'package:flutter/cupertino.dart';
import 'package:komik_seyler/business/models/action.dart' as Local;
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/util/settings.dart';

class PictureRepository {
  ApiProvider _apiProvider;

  PictureRepository([this._apiProvider]) {
    this._apiProvider ??= ApiProvider();
  }

  Future<Response> destroy({@required pictureId}) async {
    String endpoint = '/pictures/' + pictureId.toString() + '/destroy';
    Response _response = await _apiProvider.get(endpoint);
    return _response;
  }

  Future<Response> addAction({@required Local.Action action, @required Picture picture, bool value = true}) async {
    String _uuid = await Settings.getUuid();
    print(_uuid.toString());
    String endpoint = '/devices/' + _uuid + '/pictures/' + picture.id.toString() + '/actions/' + action.id.toString() + '/' + (value ? 'store' : 'destroy');
    try {
      Response _response = await _apiProvider.get(endpoint);
      return _response;
    } catch (e) {
      throw e;
    }
  }
}

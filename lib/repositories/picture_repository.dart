import 'package:flutter/cupertino.dart';
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

  Future<bool> favorite({@required int pictureId, bool value = true}) async {
    String endpoint = '/pictures/' + pictureId.toString() + '/' + (value ? 'favorite' : 'notfavorite');
    try {
      String response = await _provider.getResponse(endpoint);
    } catch (e) {
      throw e;
    }
  }

  Future<bool> like({@required int pictureId, bool value = true}) async {
    String endpoint = '/pictures/' + pictureId.toString() + '/' + (value ? 'like' : 'unlike');
    try {
      String response = await _provider.getResponse(endpoint);
    } catch (e) {
      throw e;
    }
  }
}

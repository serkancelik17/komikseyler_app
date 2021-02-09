import 'package:flutter/material.dart';
import 'package:komik_seyler/models/action.dart' as Local;
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/models/response.dart';
import 'package:komik_seyler/providers/api_provider.dart';
import 'package:komik_seyler/util/settings.dart';

class ActionRepository {
  ApiProvider provider;

  ActionRepository({this.provider}) {
    this.provider ??= ApiProvider();
  }

  Future<Local.Action> getAction({@required String actionName}) async {
    String endpoint = "/actions/" + actionName;

    String apiResponse = await provider.getResponse(endpoint);
    Response _response = responseFromJson(apiResponse);

    Local.Action action = Local.Action.fromJson(_response.data[0]);

    return action;
  }

  pictures({@required Local.Action action, int page = 1, int limit = 20}) async {
    String endpoint = "/devices/" + await Settings.getUuid() + "/actions/" + action.id.toString() + "/pictures?page=" + page.toString() + "&limit=" + limit.toString();
    String apiResponse = await provider.getResponse(endpoint);
    List<Picture> pictures = (responseFromJson(apiResponse)).data.map((pictureJson) => Picture.fromJson(pictureJson)).toList();
    return pictures;
  }
}

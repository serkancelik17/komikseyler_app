import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/sectionable.dart';
import 'package:komik_seyler/business/models/abstracts/viewable.dart';
import 'package:komik_seyler/business/models/action.dart' as Local;
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/repositories/abstracts/repositoriable.dart';
import 'package:komik_seyler/business/util/settings.dart';

class ActionRepository implements Repositoriable {
  ApiProvider provider;

  ActionRepository({this.provider}) {
    this.provider ??= ApiProvider();
  }

  Future<Local.Action> getAction({@required String actionName}) async {
    String endpoint = "/actions/" + actionName;

    String apiResponse = await provider.get(endpoint);
    Response _response = responseFromJson(apiResponse);

    Local.Action action = Local.Action.fromJson(_response.data[0]);

    return action;
  }

  Future<List<Viewable>> views({@required Sectionable section, int page = 1, int limit = 20}) async {
    String _uuid = await Settings.getUuid();
    print(_uuid.toString());
    String endpoint = "/devices/" + _uuid + "/actions/" + section.getId().toString() + "/pictures?page=" + page.toString() + "&limit=" + limit.toString();
    Response response = responseFromJson(await provider.get(endpoint));
    List<Picture> pictures = response.data['pictures'].map((pictureJson) => Picture.fromJson(pictureJson)).toList();
    return pictures;
  }
}

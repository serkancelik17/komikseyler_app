import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/abstracts/view_abstract.dart';
import 'package:komik_seyler/business/models/action.dart' as Local;
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/repositories/abstracts/repository_abstract.dart';
import 'package:komik_seyler/business/util/settings.dart';

class ActionRepository implements RepositoryAbstract {
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

  Future<List<ViewAbstract>> views({@required SectionAbstract section, int page = 1, int limit = 20}) async {
    String _uuid = await Settings.getUuid();
    print(_uuid.toString());
    String endpoint = "/devices/" + _uuid + "/actions/" + section.getId().toString() + "/pictures?page=" + page.toString() + "&limit=" + limit.toString();
    String apiResponse = await provider.get(endpoint);
    List<Picture> pictures = (responseFromJson(apiResponse)).data.map((pictureJson) => Picture.fromJson(pictureJson)).toList();
    return pictures;
  }
}

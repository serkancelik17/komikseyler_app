import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/action.dart' as Local;
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/models/mixins/view_mixin.dart';
import 'package:komik_seyler/business/models/picture.dart';
import 'package:komik_seyler/business/models/response.dart';
import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';
import 'package:komik_seyler/business/repositories/abstracts/repository_mixin.dart';
import 'package:komik_seyler/business/util/settings.dart';

class ActionRepository extends ModelRepository with RepositoryMixin {
  ApiProvider provider;

  ActionRepository({this.provider}) {
    this.provider ??= ApiProvider();
  }

  Future<Local.Action> getAction({@required String actionName}) async {
    String endpoint = "/actions/" + actionName;

    Response _response = await provider.get(endpoint);

    Local.Action action = Local.Action.fromJson(_response.data[0]);

    return action;
  }

  Future<List<ViewMixin>> views({@required SectionMixin section, int page = 1, int limit = 20}) async {
    String _uuid = await Settings.getUuid();
    print(_uuid.toString());
    String endpoint = "/devices/" + _uuid + "/actions/" + section.getId().toString() + "/pictures?page=" + page.toString() + "&limit=" + limit.toString();
    Response _response = await provider.get(endpoint);
    List<Picture> pictures = _response.data.map((pictureJson) => Picture.fromJson(pictureJson)).toList();
    return pictures;
  }
}

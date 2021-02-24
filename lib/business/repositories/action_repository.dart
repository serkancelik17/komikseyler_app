import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/repositories/repository.dart';

class ActionRepository extends Repository {
  ApiProvider provider;

  ActionRepository({this.provider}) {
    this.provider ??= ApiProvider();
  }

/*  Future<Local.Action> getAction({@required String actionName}) async {
    String endpoint = "/actions/" + actionName;

    PagelessResponse _response = PagelessResponse.fromRawJson(await provider.get(endpoint));

    Local.Action action = Local.Action().fromJson(_response.data[0]);

    return action;
  }*/
}

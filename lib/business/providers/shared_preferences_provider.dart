import 'package:komik_seyler/business/providers/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider implements Provider {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<String> get(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String response = prefs.getString(key);

    return response;
  }

  @override
  Future<String> post(String endpoint, String body) {
    // TODO: implement postResponse
    throw UnimplementedError();
  }
  //SharedPreferences prefs = await _prefs;

}

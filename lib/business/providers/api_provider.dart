import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:komix/business/util/config/env.dart';

class ApiProvider {
  String _apiUrl;
  DefaultCacheManager defaultCacheManager;
  http.Client httpClient;
  Env env;

  ApiProvider({this.defaultCacheManager, this.httpClient, this.env}) {
    this.defaultCacheManager ??= DefaultCacheManager();
    httpClient ??= http.Client();
    env ??= Env();
    _apiUrl = Env.apiUrl;
  }

  ///veriyi getir
  Future<String> get(String endpoint) async {
    final url = _apiUrl + endpoint;
    String _response;
    debugPrint("[GET] Request Url : " + url);
    try {
      //Cache yoksa httpden indir
      http.Response response = await httpClient.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _response = response.body;
      } else {
        throw Exception("GET Problem!.");
      }
    } catch (e) {
      rethrow;
    }
    return _response;
  }

  Future<String> post(String endpoint, String body) async {
    final url = _apiUrl + endpoint;
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    debugPrint("[POST] Request Url : " + url);
    debugPrint("[POST] Request Url Body : " + body);
    try {
      http.Response responseRaw = await httpClient.post(Uri.parse(url), headers: headers, body: body);
      if (responseRaw.statusCode == 200) {
        return responseRaw.body;
      } else {
        throw Exception("POST Problem!. (Status code is: " + responseRaw.statusCode.toString() + ")");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> patch(String endpoint, String body) async {
    final url = _apiUrl + endpoint;
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    debugPrint("[PATCH] Request Url : " + url);
    debugPrint("[PATCH] Request Url Body : " + body);
    try {
      http.Response responseRaw = await httpClient.patch(Uri.parse(url), headers: headers, body: body);
      if (responseRaw.statusCode == 200) {
        return responseRaw.body;
      } else {
        throw Exception("PATCH Problem!. (Status code is: " + responseRaw.statusCode.toString() + ")");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> delete(String endpoint) async {
    final url = _apiUrl + endpoint;
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    debugPrint("[DELETE] Request Url : " + url);
    try {
      http.Response responseRaw = await httpClient.delete(Uri.parse(url), headers: headers);
      if (responseRaw.statusCode == 200) {
        return responseRaw.body;
      } else {
        throw Exception("DELETE Problem!. (Status code is: " + responseRaw.statusCode.toString() + ")");
      }
    } catch (e) {
      rethrow;
    }
  }
}

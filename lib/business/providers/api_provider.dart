import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:komik_seyler/business/config/env.dart';

class ApiProvider {
  String _apiUrl = Env.baseUrl + "/api/v1";

  ApiProvider();

  ///veriyi getir
  Future<String> get(String endpoint) async {
    final url = _apiUrl + endpoint;
    debugPrint("[GET] Request Url : " + url);
    try {
      http.Response responseRaw = await http.get(url);

      if (responseRaw.statusCode == 200) {
        return responseRaw.body;
      } else {
        throw Exception("GET Problem!. (Status code is: " + responseRaw.statusCode.toString() + ")");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> post(String endpoint, String body) async {
    final url = _apiUrl + endpoint;
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    debugPrint("[POST] Request Url : " + url);
    debugPrint("[POST] Request Url Body : " + body);
    try {
      http.Response responseRaw = await http.post(url, headers: headers, body: body);
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
      http.Response responseRaw = await http.patch(url, headers: headers, body: body);
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
      http.Response responseRaw = await http.delete(url, headers: headers);
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

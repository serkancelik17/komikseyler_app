import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:komix/business/util/config/env.dart';

class ApiProvider {
  String _apiUrl = Env.apiUrl;
  DefaultCacheManager defaultCacheManager;

  ApiProvider({this.defaultCacheManager}) {
    this.defaultCacheManager ??= DefaultCacheManager();
  }

  ///veriyi getir
  Future<String> get(String endpoint) async {
    final url = _apiUrl + endpoint;
    String _response;
    debugPrint("[GET] Request Url : " + url);
    //Cache yoksa httpden indir
    if (!Env.isCached) {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _response = response.body;
      }
    } else {
      // Varsa DCM yi kullan
      File response = await defaultCacheManager.getSingleFile(url);
      print("[GET CACHED] : " + response.absolute.toString());
      if (await response.exists()) {
        _response = await response.readAsString();
      } else {
        throw Exception("GET Problem!.");
      }
    }
    return _response;
  }

  Future<String> post(String endpoint, String body) async {
    final url = _apiUrl + endpoint;
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    debugPrint("[POST] Request Url : " + url);
    debugPrint("[POST] Request Url Body : " + body);
    try {
      http.Response responseRaw = await http.post(Uri.parse(url), headers: headers, body: body);
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
      http.Response responseRaw = await http.patch(Uri.parse(url), headers: headers, body: body);
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
      http.Response responseRaw = await http.delete(Uri.parse(url), headers: headers);
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

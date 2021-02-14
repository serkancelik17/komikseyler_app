import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:komik_seyler/providers/provider.dart';
import 'package:komik_seyler/util/settings.dart';

class ApiProvider implements Provider {
  String _apiUrl = Settings.baseUrl + "/api/v1";

  ApiProvider();

  ///veriyi getir
  Future<String> getResponse(String endpoint) async {
    final url = _apiUrl + endpoint;
    debugPrint("[GET] Request Url : " + url);
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Hatalı durum kodu.(" + response.statusCode.toString() + ")");
      }
    } on HttpException {
      throw new Exception('Servis hatası!');
    } on SocketException {
      throw Exception('İnternet bağlantısı bulunamadı!');
    }
  }

  Future<String> postResponse(String endpoint) async {
    final url = _apiUrl + endpoint;
    debugPrint("[POST] Request Url : " + url);
    try {
      http.Response response = await http.post(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Sunucuya bağlanılamadı. Veri post edilemedi.");
      }
    } catch (e) {
      throw e;
    }
  }
}

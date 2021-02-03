import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:komik_seyler/providers/provider.dart';

class ApiProvider implements Provider {
  static const baseUrl = "https://api.komikseyler.serkancelik.web.tr/api/v1";

  ///veriyi getir
  Future<String> getResponse(String endpoint) async {
    final url = baseUrl + endpoint;
    debugPrint("[GET] Request Url : " + url);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Sunucuya bağlanılamadı. Veri getirilemedi.");
    }
  }

  Future<String> postResponse(String endpoint) async {
    final url = baseUrl + endpoint;
    debugPrint("[POST] Request Url : " + url);
    try {
      http.Response response = await http.post(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Sunucuya bağlanılamadı. Veri getirilemedi.");
      }
    } catch (e) {
      throw e;
    }
  }
}

class Env {
  static const String env = 'prod';

  static const String baseUrl = '${env == 'dev' ? 'http://192.168.1.11/komix.serkancelik.web.tr/public' : 'https://komix.serkancelik.web.tr'}';

  static const String apiUrl = '$baseUrl/api/v1';

  static const String imageAssetsUrl = '$baseUrl/assets/images';

  static const int pagePictureLimit = (env == 'prod') ? 20 : 5;

  static const bool isCached = true;
}

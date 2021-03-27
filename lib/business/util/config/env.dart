class Env {
  static const String env = 'dev';

  static const String baseUrl = '${env == 'dev' ? 'https://komix.serkancelik.web.tr' : 'https://komix.serkancelik.web.tr'}';

  static const String apiUrl = '$baseUrl/api/v1';

  static const String imageAssetsUrl = '$baseUrl/assets/images';

  static const int pagePictureLimit = (env == 'prod') ? 20 : 5;

  static const bool isCached = true;
}

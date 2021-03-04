class Env {
  static const String env = 'dev';

  static const String baseUrl = '${env == 'dev' ? 'http://192.168.1.20/komix.serkancelik.web.tr/public' : 'https://komix.serkancelik.web.tr'}';

  static const String imageAssetsUrl = '$baseUrl/assets/images';

  static const int pagePictureLimit = (env == 'prod') ? 10 : 3;

  static const bool isCached = false;
}

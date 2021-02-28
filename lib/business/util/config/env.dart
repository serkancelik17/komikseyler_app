class Env {
  static const String env = 'prod';

  static const String baseUrl = '${env == 'dev' ? 'http://192.168.1.20/komikseyler.serkancelik.web.tr/public' : 'https://komikseyler.serkancelik.web.tr'}';

  static const String imageAssetsUrl = '$baseUrl/assets/images';

  static const int pagePictureLimit = (env == 'prod') ? 10 : 3;

  static const bool isCached = false;
}

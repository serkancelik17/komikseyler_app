class Env {
  static const String env = 'dev';

  static const String baseUrl =
      '${env == 'dev' ? 'http://10.0.2.2/komikseyler.serkancelik.web.tr/public' : env == 'test' ? 'http://192.168.1.20/komikseyler.serkancelik.web.tr/public' : 'https://komikseyler.serkancelik.web.tr'}';

  static const String imageAssetsUrl = '$baseUrl/assets/images';

  static const int pagePictureLimit = (env == 'prod') ? 20 : 5;
}

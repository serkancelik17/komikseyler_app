import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DefaultCacheManager extends CacheManager with ImageCacheManager {
  static const key = 'libDefaultCacheData';

  DefaultCacheManager(Config config) : super(config);
}

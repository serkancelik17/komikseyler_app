import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DefaultCacheManager extends CacheManager with ImageCacheManager {
  DefaultCacheManager(Config config) : super(config);
}

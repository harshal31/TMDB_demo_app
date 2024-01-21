import 'dart:collection';

import 'package:dio/dio.dart';

class CacheManager {
  static final _cache = LinkedHashMap<String, Response>();

  static Response? getResponse(String url) {
    return _cache[url];
  }

  static void setResponse(String url, Response response) {
    _cache[url] = response;
  }

  static void clearCache() {
    _cache.clear();
  }
}

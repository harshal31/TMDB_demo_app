import 'package:tmdb_app/constants/api_key.dart';

class SocialUrlConstants {
  static String facebookUrl(String? id) {
    return "https://www.facebook.com/$id";
  }

  static String instaUrl(String? id) {
    return "https://www.instagram.com/$id";
  }

  static String twitterUrl(String? id) {
    return "https://twitter.com/$id";
  }

  static String wikiUrl(String? id) {
    return "https://www.wikidata.org/wiki/$id";
  }

  static String imdbUrl(String? id, String mediaType) {
    final tmdbTYpe = mediaType == ApiKey.person ? "name" : "title";
    return "https://www.imdb.com/$tmdbTYpe/$id";
  }
}

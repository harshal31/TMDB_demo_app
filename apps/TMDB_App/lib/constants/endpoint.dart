import 'package:tmdb_app/constants/api_key.dart';

/// All Endpoints will reside here
class Endpoint {
  static const String requestNewToken = "/authentication/token/new";
  static const String validateWithLogin = "/authentication/token/validate_with_login";
  static const String createNewSession = "/authentication/session/new";
  static const String trendingApis = "/trending/{${ApiKey.dynamicPath}}/";
  static const String latestApis = "/{${ApiKey.dynamicPath}}/{${ApiKey.dynamicPath2}}";
  static const String advanceDiscover = "/discover/{${ApiKey.dynamicPath}}";
  static const String mediaDetailApi = "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}";
  static const String mediaExternalIds = "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/external_ids";
  static const String mediaRating = "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/rating";
  static const String saveUserPref = "/account/account_id/{${ApiKey.dynamicPath}}";
  static const String personCredits = "/person/{${ApiKey.typeId}}/{${ApiKey.creditType}}";
  static const String personDetail = "/person/{${ApiKey.typeId}}";
  static const String searchCompany = "/search/company";
  static const String searchKeyword = "/search/keyword";
  static const String searchPerson = "/search/person";
  static const String searchMovie = "/search/movie";
  static const String searchTv = "/search/tv";
  static const String popularPersons = "/person/popular";
}

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
  static const String mediaAccountStates =
      "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/account_states";
  static const String mediaCredits = "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/credits";
  static const String mediaExternalIds = "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/external_ids";
  static const String mediaImages = "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/images";
  static const String mediaKeywords = "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/keywords";
  static const String mediaRecommendations =
      "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/recommendations";
  static const String mediaReviews = "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/reviews";
  static const String mediaTranslations = "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/translations";
  static const String mediaVideos = "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/videos";
  static const String mediaRating = "/{${ApiKey.mediaType}}/{${ApiKey.typeId}}/rating";
  static const String saveUserPref = "/account/account_id/{${ApiKey.dynamicPath}}";
  static const String personCredits = "/person/{${ApiKey.typeId}}/{${ApiKey.creditType}}";
  static const String personDetail = "/person/{${ApiKey.typeId}}";
}

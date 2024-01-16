/// All Endpoints will reside here
class Endpoint {
  static const String requestNewToken = "/authentication/token/new";
  static const String validateWithLogin = "/authentication/token/validate_with_login";
  static const String createNewSession = "/authentication/session/new";

  static const String trendingApis = "/trending/{dynamicPath}/";
}

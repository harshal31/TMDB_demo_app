/// All App constants will reside here
class AppConstant {
  static const String _apiVersion = "3";
  static const String baseUrl = "https://api.themoviedb.org/$_apiVersion";
  static const String requestTokenExpiryFormat = "yyyy-MM-dd HH:mm:ss 'UTC'";
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  static const String originalImageBaseUrl = "https://image.tmdb.org/t/p/original";

  static const double mobMin = 0.0;
  static const double mobMax = 480;
  static const double tabMin = 481;
  static const double tabMax = 992;
  static const double desktopMin = 993;
  static const all = "All";
}

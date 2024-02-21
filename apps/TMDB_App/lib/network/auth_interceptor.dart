import "package:dio/dio.dart";
import "package:tmdb_app/env.dart";

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String _token = Env.token;

    options.headers["Authorization"] = _token;

    super.onRequest(options, handler);
  }
}

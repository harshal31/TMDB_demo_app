import "package:dio/dio.dart";

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const String _token = "";

    options.headers["Authorization"] = _token;

    super.onRequest(options, handler);
  }
}

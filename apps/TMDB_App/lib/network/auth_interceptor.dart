import "package:dio/dio.dart";

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const String _token =
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2Y2YzOTNjMTlhYjg4MTJkNjc0MGRlMmVjNjI4MjQwNCIsInN1YiI6IjVlNjFmYmQ1MjJhZjNlMDAxM2RjZGU2NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vsaBkew5PUzysWcV78QE5rjMLqDb1ubLcdFW9G3atpc";

    options.headers["Authorization"] = _token;

    super.onRequest(options, handler);
  }
}

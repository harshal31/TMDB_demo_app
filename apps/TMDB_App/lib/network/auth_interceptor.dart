import "package:dio/dio.dart";

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const String _token =
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYTc0OGI4YzRkOWI0MTc3NTcwNzlkOTcwNTcwY2I5YyIsInN1YiI6IjVlNjFmYmQ1MjJhZjNlMDAxM2RjZGU2NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ch7YbF1EPXsYGrf-L0CfNrD66L4tdJoFb4fRCpuypRQ";

    options.headers["Authorization"] = _token;

    super.onRequest(options, handler);
  }
}

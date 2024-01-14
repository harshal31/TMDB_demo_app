import "package:common_widgets/logger/log_manager.dart";
import "package:dio/dio.dart";

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const String _token =
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NmEyOGVlZjhhZDhmZjUxMjhiM2VlYWU2NTRjMTc2ZSIsInN1YiI6IjVlNjFmYmQ1MjJhZjNlMDAxM2RjZGU2NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8Y94MkT9kZPIXD3Eoh7FQyhZOfsnvyJlIzr2boiUwIs";

    options.headers["Authorization"] = _token;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.d("status code = ${response.statusCode}");
    Log.d("response headers = ${response.headers}");
    Log.d("response data = ${response.data}");
    super.onResponse(response, handler);
  }
}

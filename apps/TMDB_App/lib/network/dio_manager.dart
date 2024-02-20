import "package:dio/dio.dart";
import "package:pretty_dio_logger/pretty_dio_logger.dart";
import "package:tmdb_app/network/auth_interceptor.dart";

class DioManager {
  late Dio dio;
  final String _baseUrl;
  final Duration? _timeOut;

  DioManager({required String baseUrl, Duration? timeOut})
      : _timeOut = timeOut,
        _baseUrl = baseUrl {
    _initializeDioClient();
  }

  void _initializeDioClient() {
    dio = Dio();
    dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _timeOut ?? const Duration(seconds: 30),
      receiveTimeout: _timeOut ?? const Duration(seconds: 30),
      sendTimeout: _timeOut ?? const Duration(seconds: 30),
    );

    dio.interceptors
      ..add(AuthInterceptor())
      ..add(PrettyDioLogger(requestHeader: true, requestBody: true, compact: false));
  }
}

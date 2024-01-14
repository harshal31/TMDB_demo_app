import "package:dio/dio.dart";
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
      connectTimeout: _timeOut ?? Duration(seconds: 20),
      receiveTimeout: _timeOut ?? Duration(seconds: 20),
      sendTimeout: _timeOut ?? Duration(seconds: 20),
    );

    dio.interceptors.add(AuthInterceptor());
  }
}

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part "search_api_service.g.dart";

@RestApi()
abstract class SearchApiService {
  factory SearchApiService(Dio dio) = _SearchApiService;
}

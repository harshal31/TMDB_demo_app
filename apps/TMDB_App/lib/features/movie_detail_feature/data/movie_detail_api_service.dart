import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'movie_detail_api_service.g.dart';

@RestApi()
class MovieDetailApiService {
  factory MovieDetailApiService(Dio dio) = _MovieDetailApiService;

}

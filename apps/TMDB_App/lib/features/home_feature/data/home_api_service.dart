import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/features/home_feature/data/model/trending.dart';

part 'home_api_service.g.dart';

@RestApi()
abstract class HomeApiService {
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET("${Endpoint.trendingApis}{${ApiKey.timeWindow}}")
  Future<HttpResponse<Trending>> getTrendingResults(
    @Path(ApiKey.dynamicPath) String dynamicPath,
    @Path(ApiKey.timeWindow) String timeWindow,
    @Query(ApiKey.language) String language,
  );

  @GET("${Endpoint.latestApis}")
  Future<HttpResponse<LatestResults>> getLatestMovies(
    @Path(ApiKey.dynamicPath) String dynamicPath,
    @Path(ApiKey.dynamicPath2) String dynamicPath2,
    @Query(ApiKey.language) String language,
    @Query(ApiKey.page) int page,
    @Query(ApiKey.region) String region,
  );

  @GET("${Endpoint.latestApis}")
  Future<HttpResponse<LatestResults>> getLatestTvSeries(
    @Path(ApiKey.dynamicPath) String dynamicPath,
    @Path(ApiKey.dynamicPath2) String dynamicPath2,
    @Query(ApiKey.language) String language,
    @Query(ApiKey.page) int page,
    @Query(ApiKey.timezone) String timezone,
  );

  @GET("${Endpoint.advanceDiscover}")
  Future<HttpResponse<LatestResults>> fetchAdvanceFilterTvAndMovies(
    @Path(ApiKey.dynamicPath) String dynamicPath,
    @Queries() Map<String, dynamic> queryMap,
  );
}

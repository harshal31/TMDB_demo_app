import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_add_rating.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';

part 'media_detail_api_service.g.dart';

@RestApi()
abstract class MediaDetailApiService {
  factory MediaDetailApiService(Dio dio) = _MediaDetailApiService;

  @GET(Endpoint.mediaDetailApi)
  Future<HttpResponse<MediaDetail?>> fetchMediaDetail(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
    @Query(ApiKey.append_to_response_key) String appendToResponse,
  );

  @POST(Endpoint.mediaRating)
  Future<HttpResponse<MediaAddRating?>> addMediaRating(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) int typeId,
    @Query(ApiKey.sessionId) String sessionId,
    @Body() Map<String, dynamic> body,
  );

  @POST(Endpoint.saveUserPref)
  Future<HttpResponse<MediaAddRating?>> saveUserPref(
    @Path(ApiKey.dynamicPath) String dynamicPath,
    @Query(ApiKey.sessionId) String sessionId,
    @Body() Map<String, dynamic> body,
  );

  @POST(Endpoint.mediaRating)
  Future<HttpResponse<MediaAddRating?>> addMediaRatingWithoutSessionId(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) int typeId,
    @Body() Map<String, dynamic> body,
  );

  @POST(Endpoint.saveUserPref)
  Future<HttpResponse<MediaAddRating?>> saveUserPrefWithoutSessionId(
    @Path(ApiKey.dynamicPath) String dynamicPath,
    @Body() Map<String, dynamic> body,
  );
}

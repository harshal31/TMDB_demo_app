import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_account_state.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_credits.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_external_id.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_images.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_keywords.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_add_rating.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_recommendations.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_reviews.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_translations.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_videos.dart';

part 'media_detail_api_service.g.dart';

@RestApi()
abstract class MediaDetailApiService {
  factory MediaDetailApiService(Dio dio) = _MediaDetailApiService;

  @GET(Endpoint.mediaDetailApi)
  Future<HttpResponse<MediaDetail?>> fetchMediaDetail(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
  );

  @GET(Endpoint.mediaAccountStates)
  Future<HttpResponse<MediaAccountState?>> fetchMediaAccountStates(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.sessionId) String sessionId,
  );

  @GET(Endpoint.mediaCredits)
  Future<HttpResponse<MediaCredits?>> fetchMediaCredits(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
  );

  @GET(Endpoint.mediaExternalIds)
  Future<HttpResponse<MediaExternalId?>> fetchMediaExternalIds(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
  );

  @GET(Endpoint.mediaImages)
  Future<HttpResponse<MediaImages?>> fetchMediaImages(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
  );

  @GET(Endpoint.mediaKeywords)
  Future<HttpResponse<MediaKeywords?>> fetchMediaKeywords(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
  );

  @GET(Endpoint.mediaRecommendations)
  Future<HttpResponse<MediaRecommendations?>> fetchMediaRecommendations(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
    @Query(ApiKey.page) int page,
  );

  @GET(Endpoint.mediaReviews)
  Future<HttpResponse<MediaReviews?>> fetchMediaReviews(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
    @Query(ApiKey.page) int page,
  );

  @GET(Endpoint.mediaTranslations)
  Future<HttpResponse<MediaTranslations?>> fetchMediaTranslations(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
  );

  @GET(Endpoint.mediaVideos)
  Future<HttpResponse<MediaVideos?>> fetchMediaVideos(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
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
}

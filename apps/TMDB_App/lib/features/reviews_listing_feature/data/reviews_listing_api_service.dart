import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/routes/route_param.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_reviews.dart';

part 'reviews_listing_api_service.g.dart';

@RestApi()
abstract class ReviewsListingApiService {
  factory ReviewsListingApiService(Dio dio) = _ReviewsListingApiService;

  @GET(Endpoint.mediaReviews)
  Future<HttpResponse<MediaReviews>> getMediaReviews(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) int mediaId,
    @Query(ApiKey.page) int page,
    @Query(ApiKey.language) String language,
  );
}

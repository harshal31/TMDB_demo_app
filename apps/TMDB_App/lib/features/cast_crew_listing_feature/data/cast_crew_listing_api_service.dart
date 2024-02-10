import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_credits.dart';

part 'cast_crew_listing_api_service.g.dart';

@RestApi()
abstract class CastCrewListingApiService {
  factory CastCrewListingApiService(Dio dio) = _CastCrewListingApiService;

  @GET(Endpoint.mediaCredit)
  Future<HttpResponse<MediaCredits>> getMediaCredits(
    @Path(ApiKey.mediaType) String dynamicPath,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
  );
}

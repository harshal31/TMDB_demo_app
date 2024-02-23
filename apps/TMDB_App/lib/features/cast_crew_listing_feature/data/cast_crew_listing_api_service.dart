import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/routes/route_param.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';

part 'cast_crew_listing_api_service.g.dart';

@RestApi()
abstract class CastCrewListingApiService {
  factory CastCrewListingApiService(Dio dio) = _CastCrewListingApiService;

  @GET(Endpoint.mediaDetailApi)
  Future<HttpResponse<MediaDetail>> fetchMediaDetail(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
    @Query(ApiKey.append_to_response_key) String appendToResponse,
  );
}

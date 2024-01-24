import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_external_id.dart';
import 'package:tmdb_app/features/person_detail_feature/data/model/person_credit.dart';
import 'package:tmdb_app/features/person_detail_feature/data/model/person_detail.dart';

part 'person_detail_api_service.g.dart';

@RestApi()
abstract class PersonDetailApiService {
  factory PersonDetailApiService(Dio dio) = _PersonDetailApiService;

  @GET(Endpoint.mediaExternalIds)
  Future<HttpResponse<MediaExternalId>> fetchMediaExternalIds(
    @Path(ApiKey.mediaType) String mediaType,
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
  );

  @GET(Endpoint.personCredits)
  Future<HttpResponse<PersonCredit?>> fetchPersonCredits(
    @Path(ApiKey.typeId) String typeId,
    @Path(ApiKey.creditType) String creditType,
    @Query(ApiKey.language) String language,
  );

  @GET(Endpoint.personDetail)
  Future<HttpResponse<PersonDetail?>> fetchPersonDetail(
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
  );
}

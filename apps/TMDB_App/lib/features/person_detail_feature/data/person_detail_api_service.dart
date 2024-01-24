import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/person_detail_feature/data/model/person_detail.dart';

part 'person_detail_api_service.g.dart';

@RestApi()
abstract class PersonDetailApiService {
  factory PersonDetailApiService(Dio dio) = _PersonDetailApiService;

  @GET(Endpoint.personDetail)
  Future<HttpResponse<PersonDetail?>> fetchPersonDetail(
    @Path(ApiKey.typeId) String typeId,
    @Query(ApiKey.language) String language,
    @Query(ApiKey.append_to_response_key) String appendToResponse,
  );
}

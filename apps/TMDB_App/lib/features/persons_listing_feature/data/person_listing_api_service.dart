import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';

part 'person_listing_api_service.g.dart';

@RestApi()
abstract class PersonListingApiService {
  factory PersonListingApiService(Dio dio) = _PersonListingApiService;

  @GET(Endpoint.popularPersons)
  Future<HttpResponse<SearchPersonModel>> getPopularPersons(
    @Query(ApiKey.language) String language,
    @Query(ApiKey.page) int page,
  );
}

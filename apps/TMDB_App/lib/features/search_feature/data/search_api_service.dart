import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/endpoint.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_company_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_keywords_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_movie_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_tv_model.dart';

part "search_api_service.g.dart";

@RestApi()
abstract class SearchApiService {
  factory SearchApiService(Dio dio) = _SearchApiService;

  @GET(Endpoint.searchCompany)
  Future<HttpResponse<SearchCompanyModel>> searchCompanies(
    @Query(ApiKey.query) String query,
    @Query(ApiKey.page) int page,
  );

  @GET(Endpoint.searchKeyword)
  Future<HttpResponse<SearchKeywordsModel>> searchKeywords(
    @Query(ApiKey.query) String query,
    @Query(ApiKey.page) int page,
  );

  @GET(Endpoint.searchPerson)
  Future<HttpResponse<SearchPersonModel>> searchPersons(
    @Query(ApiKey.query) String query,
    @Query(ApiKey.page) int page,
  );

  @GET(Endpoint.searchMovie)
  Future<HttpResponse<SearchMovieModel>> searchMovies(
    @Query(ApiKey.query) String query,
    @Query(ApiKey.page) int page,
  );

  @GET(Endpoint.searchTv)
  Future<HttpResponse<SearchTvModel>> searchTvs(
    @Query(ApiKey.query) String query,
    @Query(ApiKey.page) int page,
  );
}

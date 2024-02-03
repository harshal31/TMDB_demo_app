import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_company_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_keywords_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_movie_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_tv_model.dart';
import 'package:tmdb_app/features/search_feature/data/search_api_service.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/combine_count_state.dart';
import 'package:tmdb_app/network/error_response.dart';

class CombineCountUseCase {
  final SearchApiService _searchApiService;

  CombineCountUseCase(this._searchApiService);

  Future<Either<ErrorResponse, CombineCountState>> fetchCountInitially(String query) async {
    final response = await Future.wait([
      _searchApiService.searchMovies(query, 1),
      _searchApiService.searchTvs(query, 1),
      _searchApiService.searchPersons(query, 1),
      _searchApiService.searchKeywords(query, 1),
      _searchApiService.searchCompanies(query, 1),
    ]);

    if (response.all((t) => t.response.statusCode != 200)) {
      return left(ErrorResponse(errorCode: -1, errorMessage: "Not able to get count"));
    }

    return right(CombineCountState(
      movieCount: (response[0].data as SearchMovieModel).totalResults ?? 0,
      tvShowsCount: (response[1].data as SearchTvModel).totalResults ?? 0,
      personCount: (response[2].data as SearchPersonModel).totalResults ?? 0,
      keywordsCount: (response[3].data as SearchKeywordsModel).totalResults ?? 0,
      companyCount: (response[4].data as SearchCompanyModel).totalResults ?? 0,
      uniqueKey: UniqueKey().toString(),
    ));
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_company_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_keywords_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_movie_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_tv_model.dart';
import 'package:tmdb_app/features/search_feature/data/search_api_service.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/combine_search_state.dart';
import 'package:tmdb_app/network/error_response.dart';

class CombineSearchResultUseCase {
  final SearchApiService _searchApiService;

  CombineSearchResultUseCase(this._searchApiService);

  Future<Either<ErrorResponse, CombineSearchState>> consolidateSearchResults(String query) async {
    final response = await Future.wait([
      _searchApiService.searchMovies(query, 1),
      _searchApiService.searchTvs(query, 1),
      _searchApiService.searchPersons(query, 1),
      _searchApiService.searchKeywords(query, 1),
      _searchApiService.searchCompanies(query, 1),
    ]);

    if (response.all((t) => t.response.statusCode != 200)) {
      return left(
        ErrorResponse(errorCode: -1, errorMessage: "Not able to get search result for $query"),
      );
    }

    return right(
      CombineSearchState.initial().copyWith(
        query: query,
        movies: {
          "${(response[0].data as SearchMovieModel).totalResults ?? 0}":
              (response[0].data as SearchMovieModel).movies?.take(10).toList() ?? []
        },
        tvShows: {
          "${(response[1].data as SearchTvModel).totalResults ?? 0}":
              (response[1].data as SearchTvModel).tvShows?.take(10).toList() ?? []
        },
        persons: {
          "${(response[2].data as SearchPersonModel).totalResults ?? 0}":
              (response[2].data as SearchPersonModel).persons?.take(10).toList() ?? []
        },
        searchKeywords: {
          "${(response[3].data as SearchKeywordsModel).totalResults ?? 0}":
              (response[3].data as SearchKeywordsModel).searchKeywords?.take(10).toList() ?? []
        },
        companies: {
          "${(response[4].data as SearchCompanyModel).totalResults ?? 0}":
              (response[4].data as SearchCompanyModel).companies?.take(10).toList() ?? []
        },
      ),
    );
  }
}

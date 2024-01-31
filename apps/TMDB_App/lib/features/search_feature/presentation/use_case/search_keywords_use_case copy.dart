import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_keywords_model.dart';
import 'package:tmdb_app/features/search_feature/data/search_api_service.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class SearchKeywordsUseCase {
  final SearchApiService _searchApiService;

  const SearchKeywordsUseCase(this._searchApiService);

  Future<Either<ErrorResponse, SearchKeywordsModel>> searchKeywords(String query, int page) async {
    final response = await apiCall(() => _searchApiService.searchKeywords(query, page));
    return response.fold((l) => left(l), (r) => right(r));
  }
}

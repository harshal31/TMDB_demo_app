import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/features/search_feature/data/search_api_service.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class SearchPersonsUseCase {
  final SearchApiService _searchApiService;

  const SearchPersonsUseCase(this._searchApiService);

  Future<Either<ErrorResponse, SearchPersonModel>> searchPersons(String query, int page) async {
    final response = await apiCall(() => _searchApiService.searchPersons(query, page));
    return response.fold((l) => left(l), (r) => right(r));
  }
}

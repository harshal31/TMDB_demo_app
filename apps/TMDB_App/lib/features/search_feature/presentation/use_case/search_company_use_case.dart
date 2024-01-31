import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_company_model.dart';
import 'package:tmdb_app/features/search_feature/data/search_api_service.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class SearchCompanyUseCase {
  final SearchApiService _searchApiService;

  const SearchCompanyUseCase(this._searchApiService);

  Future<Either<ErrorResponse, SearchCompanyModel>> searchCompanies(String query, int page) async {
    final response = await apiCall(() => _searchApiService.searchCompanies(query, page));
    return response.fold((l) => left(l), (r) => right(r));
  }
}

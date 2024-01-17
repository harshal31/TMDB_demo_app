import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/data/home_api_service.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class TvAdvanceFilterUseCase {
  final HomeApiService _homeApiService;

  TvAdvanceFilterUseCase(this._homeApiService);

  Future<Either<ErrorResponse, List<LatestData>>> advanceTvFilter({
    String? airDateGte,
    String? airDateLte,
    int? firstAirDateYear,
    String? firstAirDateGte,
    String? firstAirDateLte,
    bool? includeAdult = false,
    bool? includeNullFirstAirDates = false,
    bool? screenedTheatrically,
    String? sortBy = ApiKey.defaultSortOrder,
    double? voteAverageGte,
    double? voteAverageLte,
    double? voteCountGte,
    double? voteCountLte,
    String? watchRegion,
    String? withCompanies,
    String? withGenres,
    String? withKeywords,
    int? withNetworks,
    String? withOriginCountry,
    String? withOriginalLanguage,
    int? withRuntimeGte,
    int? withRuntimeLte,
    String? withStatus,
    String? withWatchMonetizationTypes,
    String? withWatchProviders,
    String? withoutCompanies,
    String? withoutGenres,
    String? withoutKeywords,
    String? withoutWatchProviders,
    String? withType,
    String? language = ApiKey.defaultLanguage,
    int? page = 1,
    String? timezone,
  }) async {
    final queryMap = {
      ApiKey.air_date_gte: airDateGte,
      ApiKey.air_date_lte: airDateLte,
      ApiKey.first_air_date_year: firstAirDateYear,
      ApiKey.first_air_date_gte: firstAirDateGte,
      ApiKey.first_air_date_lte: firstAirDateLte,
      ApiKey.include_null_first_air_dates: includeNullFirstAirDates,
      ApiKey.screened_theatrically: screenedTheatrically,
      ApiKey.with_networks: withNetworks,
      ApiKey.with_status: withStatus,
      ApiKey.with_type: withType,
      ApiKey.include_adult: includeAdult,
      ApiKey.sort_by: sortBy,
      ApiKey.vote_average_gte: voteAverageGte,
      ApiKey.vote_average_lte: voteAverageLte,
      ApiKey.vote_count_gte: voteCountGte,
      ApiKey.vote_count_lte: voteCountLte,
      ApiKey.watch_region: watchRegion,
      ApiKey.with_companies: withCompanies,
      ApiKey.with_genres: withGenres,
      ApiKey.with_keywords: withKeywords,
      ApiKey.with_origin_country: withOriginCountry,
      ApiKey.with_original_language: withOriginalLanguage,
      ApiKey.with_runtime_gte: withRuntimeGte,
      ApiKey.with_runtime_lte: withRuntimeLte,
      ApiKey.with_watch_monetization_types: withWatchMonetizationTypes,
      ApiKey.with_watch_providers: withWatchProviders,
      ApiKey.without_companies: withoutCompanies,
      ApiKey.without_genres: withoutGenres,
      ApiKey.without_keywords: withoutKeywords,
      ApiKey.without_watch_providers: withoutWatchProviders,
      ApiKey.language: language,
      ApiKey.page: page,
      ApiKey.timezone: timezone,
    }.filter((value) => value != null);

    final result = await apiCall(
      () => _homeApiService.fetchAdvanceFilterTvAndMovies(ApiKey.tv, queryMap),
    );

    return result.fold(
      (l) => left(l),
      (r) => right(r.latestData ?? []),
    );
  }
}

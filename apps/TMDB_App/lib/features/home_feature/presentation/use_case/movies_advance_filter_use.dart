import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/data/home_api_service.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class MoviesAdvanceFilterUseCase {
  final HomeApiService _homeApiService;

  MoviesAdvanceFilterUseCase(this._homeApiService);

  Future<Either<ErrorResponse, LatestResults>> advanceMovieFilter({
    String? certification,
    String? certificationGte,
    String? certificationLte,
    String? certificationCountry,
    bool? includeAdult = false,
    bool? includeVideo = false,
    int? primaryReleaseYear,
    String? primaryReleaseDateGte,
    String? primaryReleaseDateLte,
    String? releaseDateGte,
    String? releaseDateLte,
    String? sortBy = ApiKey.defaultSortOrder,
    double? voteAverageGte,
    double? voteAverageLte,
    double? voteCountGte,
    double? voteCountLte,
    String? watchRegion,
    String? withCast,
    String? withCompanies,
    String? withCrew,
    String? withGenres,
    String? withKeywords,
    String? withOriginCountry,
    String? withOriginalLanguage,
    String? withPeople,
    int? withReleaseType,
    int? withRuntimeGte,
    int? withRuntimeLte,
    String? withWatchMonetizationTypes,
    String? withWatchProviders,
    String? withoutCompanies,
    String? withoutGenres,
    String? withoutKeywords,
    String? withoutWatchProviders,
    int? year,
    int? page = 1,
    String? language = ApiKey.defaultLanguage,
    String? region,
  }) async {
    final queryMap = {
      ApiKey.certification: certification,
      ApiKey.certification_gte: certificationGte,
      ApiKey.certification_lte: certificationLte,
      ApiKey.certification_country: certificationCountry,
      ApiKey.include_adult: includeAdult,
      ApiKey.include_video: includeVideo,
      ApiKey.primary_release_year: primaryReleaseYear,
      ApiKey.primary_release_date_gte: primaryReleaseDateGte,
      ApiKey.primary_release_date_lte: primaryReleaseDateLte,
      ApiKey.release_date_gte: releaseDateGte,
      ApiKey.release_date_lte: releaseDateLte,
      ApiKey.sort_by: sortBy,
      ApiKey.vote_average_gte: voteAverageGte,
      ApiKey.vote_average_lte: voteAverageLte,
      ApiKey.vote_count_gte: voteCountGte,
      ApiKey.vote_count_lte: voteCountLte,
      ApiKey.watch_region: watchRegion,
      ApiKey.with_cast: withCast,
      ApiKey.with_companies: withCompanies,
      ApiKey.with_crew: withCrew,
      ApiKey.with_genres: withGenres,
      ApiKey.with_keywords: withKeywords,
      ApiKey.with_origin_country: withOriginCountry,
      ApiKey.with_original_language: withOriginalLanguage,
      ApiKey.with_people: withPeople,
      ApiKey.with_release_type: withReleaseType,
      ApiKey.with_runtime_gte: withRuntimeGte,
      ApiKey.with_runtime_lte: withRuntimeLte,
      ApiKey.with_watch_monetization_types: withWatchMonetizationTypes,
      ApiKey.with_watch_providers: withWatchProviders,
      ApiKey.without_companies: withoutCompanies,
      ApiKey.without_genres: withoutGenres,
      ApiKey.without_keywords: withoutKeywords,
      ApiKey.without_watch_providers: withoutWatchProviders,
      ApiKey.year: year,
      ApiKey.page: page,
      ApiKey.language: language,
      ApiKey.region: region,
    }.filter((value) => value != null);

    final result = await apiCall(
      () => _homeApiService.fetchAdvanceFilterTvAndMovies(ApiKey.movie, queryMap),
    );

    return result.fold(
      (l) => left(l),
      (r) => right(r),
    );
  }
}

class AdvanceFilterState with EquatableMixin {
  final AdvanceFilterStatus? latestStatus;
  final List<LatestData> results;
  final int pos;

  AdvanceFilterState(
    this.latestStatus,
    this.results,
    this.pos,
  );

  factory AdvanceFilterState.initial() {
    return AdvanceFilterState(null, [], 0);
  }

  AdvanceFilterState copyWith({
    AdvanceFilterStatus? latestStatus,
    List<LatestData>? results,
    int? pos,
  }) {
    return AdvanceFilterState(
      latestStatus ?? this.latestStatus,
      results ?? this.results,
      pos ?? this.pos,
    );
  }

  List<String> get getImageUrls {
    return this.results.map((e) => e.getImagePath()).toList();
  }

  List<String> getFreeToWatchMovieTabTitles(BuildContext context) {
    return [
      context.tr.movies,
      context.tr.tvSeries,
    ];
  }

  String getFreeToWatchText(BuildContext context, int pos) {
    final tr = context.tr.freeToWatch;
    final result = pos == 0 ? context.tr.movies : context.tr.tvSeries;
    return "$tr $result";
  }

  @override
  List<Object?> get props => [latestStatus, results, pos];
}

sealed class AdvanceFilterStatus with EquatableMixin {}

class AdvanceFilterStatusLoading extends AdvanceFilterStatus {
  final String uniqueKey;

  AdvanceFilterStatusLoading(this.uniqueKey);

  @override
  List<Object?> get props => [uniqueKey];
}

class AdvanceFilterStatusDone extends AdvanceFilterStatus {
  final String uniqueKey;

  AdvanceFilterStatusDone(this.uniqueKey);

  @override
  List<Object?> get props => [uniqueKey];
}

class AdvanceFilterPaginationState with EquatableMixin {
  final AdvancePaginationState advancePaginationState;

  AdvanceFilterPaginationState(this.advancePaginationState);

  factory AdvanceFilterPaginationState.initial() {
    return AdvanceFilterPaginationState(AdvanceFilterPaginationNone());
  }

  AdvanceFilterPaginationState copyWith({AdvancePaginationState? advancePaginationState}) {
    return AdvanceFilterPaginationState(advancePaginationState ?? this.advancePaginationState);
  }

  @override
  List<Object?> get props => [advancePaginationState];
}

sealed class AdvancePaginationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class AdvanceFilterPaginationNone extends AdvancePaginationState {}

class AdvanceFilterPaginationLoading extends AdvancePaginationState {}

class AdvanceFilterPaginationLoaded extends AdvancePaginationState {
  final LatestResults? latestResults;
  final List<LatestData> results;
  final bool hasReachedMax;

  AdvanceFilterPaginationLoaded(this.latestResults, this.results, this.hasReachedMax);

  factory AdvanceFilterPaginationLoaded.initial() {
    return AdvanceFilterPaginationLoaded(null, [], false);
  }

  AdvanceFilterPaginationLoaded copyWith({
    LatestResults? latestResults,
    List<LatestData>? results,
    bool? hasReachedMax,
  }) {
    return AdvanceFilterPaginationLoaded(
      latestResults ?? this.latestResults,
      results ?? this.results,
      hasReachedMax ?? this.hasReachedMax,
    );
  }

  List<String> get getImageUrls {
    return this.results.map((e) => e.getImagePath()).toList();
  }

  @override
  List<Object?> get props => [
        results,
        latestResults,
        hasReachedMax,
      ];
}

class AdvanceFilterPaginationError extends AdvancePaginationState {
  final String error;

  AdvanceFilterPaginationError(this.error);
}

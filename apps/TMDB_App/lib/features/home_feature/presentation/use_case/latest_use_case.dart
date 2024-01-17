import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/data/home_api_service.dart';
import 'package:tmdb_app/features/home_feature/data/model/latest_results.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class LatestUseCase {
  final HomeApiService _homeApiService;
  final Map<String, String> dynamicPathMapper = {
    "Now Playing": ApiKey.nowPlaying,
    "Popular": ApiKey.popular,
    "Top Rated": ApiKey.topRated,
    "Upcoming": ApiKey.upcoming,
    "Airing Today": ApiKey.airingToday,
    "On The Air": ApiKey.onTheAir,
  };

  LatestUseCase(this._homeApiService);

  Future<Either<ErrorResponse, List<LatestData>>> fetchLatestResultsBasedOnMediaType(
    String mediaType,
    String currentTab, {
    String language = ApiKey.defaultLanguage,
    int page = 1,
    String region = "",
    String timezone = "",
  }) async {
    final dynamicPath = dynamicPathMapper[currentTab] ?? "";
    final networkCall = mediaType == ApiKey.movie
        ? _homeApiService.getLatestMovies(mediaType, dynamicPath, language, page, region)
        : _homeApiService.getLatestTvSeries(mediaType, dynamicPath, language, page, timezone);

    final result = await apiCall(() => networkCall);

    return result.fold(
      (l) => left(l),
      (r) => right(r.latestData ?? []),
    );
  }
}

class LatestState with EquatableMixin {
  final LatestSectionStatus? latestStatus;
  final List<LatestData> results;

  LatestState(this.latestStatus, this.results);

  factory LatestState.initial() {
    return LatestState(null, []);
  }

  LatestState copyWith({
    LatestSectionStatus? latestStatus,
    List<LatestData>? results,
  }) {
    return LatestState(
      latestStatus ?? this.latestStatus,
      results ?? this.results,
    );
  }

  List<String> get getImageUrls {
    return this.results.map((e) => e.getImagePath()).toList();
  }

  @override
  List<Object?> get props => [latestStatus, results];
}

sealed class LatestSectionStatus with EquatableMixin {}

class LatestSectionLoading extends LatestSectionStatus {
  final String uniqueKey;

  LatestSectionLoading(this.uniqueKey);

  @override
  List<Object?> get props => [uniqueKey];
}

class LatestSectionDone extends LatestSectionStatus {
  final String uniqueKey;

  LatestSectionDone(this.uniqueKey);

  @override
  List<Object?> get props => [uniqueKey];
}

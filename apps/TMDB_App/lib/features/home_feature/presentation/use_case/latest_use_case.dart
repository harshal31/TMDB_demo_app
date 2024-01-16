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

  Future<Either<ErrorResponse, LatestResults>> fetchLatestResultsBasedOnMediaType(
    String mediaType,
    String currentTab, {
    String language = ApiKey.defaultLanguage,
    int page = 1,
    String region = "",
  }) async {
    final dynamicPath = dynamicPathMapper[currentTab] ?? "";
    final networkCall = mediaType == ApiKey.movie
        ? _homeApiService.getLatestMovies(mediaType, dynamicPath, language, page, region)
        : _homeApiService.getLatestMovies(mediaType, dynamicPath, language, page, region);

    final result = await apiCall(() => networkCall);

    return result.fold(
      (l) => left(l),
      (r) => right(r),
    );
  }
}

class LatestState with EquatableMixin {
  LatestState();

  factory LatestState.initial() {
    return LatestState();
  }

  @override
  List<Object?> get props => [];
}

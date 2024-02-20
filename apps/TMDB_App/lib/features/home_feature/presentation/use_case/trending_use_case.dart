import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/data/home_api_service.dart';
import 'package:tmdb_app/features/home_feature/data/model/trending.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class TrendingUseCase {
  final HomeApiService _homeApiService;

  TrendingUseCase(this._homeApiService);

  Future<Either<ErrorResponse, Trending>> getTrendingResult(
    int currentTrendPos,
    String timeWindow, {
    String language = ApiKey.defaultLanguage,
  }) async {
    final dynamicPath = _getDynamicPath(currentTrendPos);
    final result = await apiCall(
      () => _homeApiService.getTrendingResults(dynamicPath, timeWindow, language),
    );

    return result.fold(
      (l) => left(l),
      (r) => right(r),
    );
  }

  String _getDynamicPath(int pos) {
    if (pos == 0) {
      return ApiKey.all;
    } else if (pos == 1) {
      return ApiKey.movie;
    } else if (pos == 2) {
      return ApiKey.tv;
    } else {
      return ApiKey.person;
    }
  }
}

class TrendingState with EquatableMixin {
  final Trending? trendingResult;
  final TrendingStatus? trendingStatus;
  final String? error;

  TrendingState(this.trendingResult, this.trendingStatus, this.error);

  factory TrendingState.initial() {
    return TrendingState(null, null, null);
  }

  TrendingState copyWith({
    Trending? trendingResult,
    TrendingStatus? trendingStatus,
    String? error,
  }) {
    return TrendingState(
      trendingResult ?? this.trendingResult,
      trendingStatus ?? this.trendingStatus,
      error ?? this.error,
    );
  }

  List<String> get getImageUrls {
    return this.trendingResult?.results?.map((e) => e.getImagePath()).toList() ?? [];
  }

  @override
  List<Object?> get props => [trendingResult, trendingStatus, error];
}

sealed class TrendingStatus with EquatableMixin {}

class TrendingLoading extends TrendingStatus {
  final String uniqueKey;

  TrendingLoading(this.uniqueKey);

  @override
  List<Object?> get props => [uniqueKey];
}

class TrendingDone extends TrendingStatus {
  final String uniqueKey;

  TrendingDone(this.uniqueKey);

  @override
  List<Object?> get props => [uniqueKey];
}

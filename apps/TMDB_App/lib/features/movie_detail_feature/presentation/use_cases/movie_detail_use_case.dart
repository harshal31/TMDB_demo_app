import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/movie_detail_model.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/movie_detail_api_service.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';
import 'package:tmdb_app/utils/either_extensions.dart';

class MovieDetailUseCase {
  final MovieDetailApiService _movieDetailApiService;

  MovieDetailUseCase(this._movieDetailApiService);

  Future<Either<ErrorResponse, MovieDetailModel>> fetchMovieDetails(
    String typeId,
    String mediaType,
    String sessionId, {
    String language = ApiKey.defaultLanguage,
    int page = 1,
  }) async {
    MovieDetailModel model = MovieDetailModel();
    final movieDetail = await apiCall(
      () => _movieDetailApiService.fetchMediaDetail(mediaType, typeId, language),
    );
    final movieAccountState = await apiCall(
      () => _movieDetailApiService.fetchMediaAccountStates(mediaType, typeId, sessionId),
    );

    final movieCredits = await apiCall(
      () => _movieDetailApiService.fetchMediaCredits(mediaType, typeId, language),
    );

    final mediaExternalIds = await apiCall(
      () => _movieDetailApiService.fetchMediaExternalIds(mediaType, typeId, language),
    );

    final mediaImages = await apiCall(
      () => _movieDetailApiService.fetchMediaImages(mediaType, typeId, language),
    );

    final mediaKeywords = await apiCall(
      () => _movieDetailApiService.fetchMediaKeywords(mediaType, typeId),
    );

    final mediaRecommendations = await apiCall(
      () => _movieDetailApiService.fetchMediaRecommendations(mediaType, typeId, language, page),
    );

    final mediaReviews = await apiCall(
      () => _movieDetailApiService.fetchMediaReviews(mediaType, typeId, language, page),
    );

    final mediaTranslations = await apiCall(
      () => _movieDetailApiService.fetchMediaTranslations(mediaType, typeId),
    );

    final mediaVideos = await apiCall(
      () => _movieDetailApiService.fetchMediaVideos(mediaType, typeId, language),
    );

    model = model.copyWith(
      mediaDetail: movieDetail.getRightOrNull,
      mediaAccountState: movieAccountState.getRightOrNull,
      mediaCredits: movieCredits.getRightOrNull,
      mediaExternalId: mediaExternalIds.getRightOrNull,
      mediaImages: mediaImages.getRightOrNull,
      mediaKeywords: mediaKeywords.getRightOrNull,
      mediaRecommendations: mediaRecommendations.getRightOrNull,
      mediaReviews: mediaReviews.getRightOrNull,
      mediaTranslations: mediaTranslations.getRightOrNull,
      mediaVideos: mediaVideos.getRightOrNull,
    );

    if (model.shouldReturnFailure()) {
      return left(
        ErrorResponse(errorCode: -1, errorMessage: "Not able to fetch movie details for $typeId"),
      );
    }

    return right(model);
  }
}

class MovieDetailState with EquatableMixin {
  final MovieDetailModel movieDetailModel;
  final MovieDetailStatus movieDetailState;

  MovieDetailState(this.movieDetailModel, this.movieDetailState);

  factory MovieDetailState.initial() {
    return MovieDetailState(
      MovieDetailModel(),
      MovieDetailNone(),
    );
  }

  MovieDetailState copyWith({
    MovieDetailModel? movieDetailModel,
    MovieDetailStatus? movieDetailState,
  }) {
    return MovieDetailState(
      movieDetailModel ?? this.movieDetailModel,
      movieDetailState ?? this.movieDetailState,
    );
  }

  @override
  List<Object?> get props => [movieDetailModel, movieDetailState];
}

sealed class MovieDetailStatus with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class MovieDetailNone extends MovieDetailStatus {}

class MovieDetailLoading extends MovieDetailStatus {}

class MovieDetailSuccess extends MovieDetailStatus {}

class MovieDetailFailure extends MovieDetailStatus {
  final ErrorResponse errorResponse;

  MovieDetailFailure(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}

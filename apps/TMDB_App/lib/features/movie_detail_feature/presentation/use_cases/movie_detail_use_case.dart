import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_account_state.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_credits.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_external_id.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_images.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_keywords.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_recommendations.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_reviews.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_translations.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_videos.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail_model.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/media_detail_api_service.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';
import 'package:tmdb_app/utils/either_extensions.dart';

class MovieDetailUseCase {
  final MediaDetailApiService _movieDetailApiService;

  const MovieDetailUseCase(this._movieDetailApiService);

  Future<Either<ErrorResponse, MediaDetailModel>> fetchMovieDetails(
    String typeId,
    String mediaType,
    String sessionId, {
    String language = ApiKey.defaultLanguage,
    int page = 1,
  }) async {
    MediaDetailModel model = MediaDetailModel();
    final responses = await Future.wait([
      apiCall(() => _movieDetailApiService.fetchMediaDetail(mediaType, typeId, language)),
      apiCall(() => _movieDetailApiService.fetchMediaAccountStates(mediaType, typeId, sessionId)),
      apiCall(() => _movieDetailApiService.fetchMediaCredits(mediaType, typeId, language)),
      apiCall(() => _movieDetailApiService.fetchMediaExternalIds(mediaType, typeId, language)),
      apiCall(() => _movieDetailApiService.fetchMediaImages(mediaType, typeId, "")),
      apiCall(() => _movieDetailApiService.fetchMediaKeywords(mediaType, typeId)),
      apiCall(() =>
          _movieDetailApiService.fetchMediaRecommendations(mediaType, typeId, language, page)),
      apiCall(() => _movieDetailApiService.fetchMediaReviews(mediaType, typeId, language, page)),
      apiCall(() => _movieDetailApiService.fetchMediaTranslations(mediaType, typeId)),
      apiCall(() => _movieDetailApiService.fetchMediaVideos(mediaType, typeId, "")),
    ]);

    model = model.copyWith(
      mediaDetail: (responses[0] as Either<ErrorResponse, MediaDetail?>).getRightOrNull,
      mediaAccountState: (responses[1] as Either<ErrorResponse, MediaAccountState?>).getRightOrNull,
      mediaCredits: (responses[2] as Either<ErrorResponse, MediaCredits?>).getRightOrNull,
      mediaExternalId: (responses[3] as Either<ErrorResponse, MediaExternalId?>).getRightOrNull,
      mediaImages: (responses[4] as Either<ErrorResponse, MediaImages?>).getRightOrNull,
      mediaKeywords: (responses[5] as Either<ErrorResponse, MediaKeywords?>).getRightOrNull,
      mediaRecommendations:
          (responses[6] as Either<ErrorResponse, MediaRecommendations?>).getRightOrNull,
      mediaReviews: (responses[7] as Either<ErrorResponse, MediaReviews?>).getRightOrNull,
      mediaTranslations: (responses[8] as Either<ErrorResponse, MediaTranslations?>).getRightOrNull,
      mediaVideos: (responses[9] as Either<ErrorResponse, MediaVideos?>).getRightOrNull,
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
  final MediaDetailModel mediaDetailModel;
  final MovieDetailStatus movieDetailState;

  MovieDetailState(this.mediaDetailModel, this.movieDetailState);

  factory MovieDetailState.initial() {
    return MovieDetailState(
      MediaDetailModel(),
      MovieDetailNone(),
    );
  }

  MovieDetailState copyWith({
    MediaDetailModel? mediaDetailModel,
    MovieDetailStatus? movieDetailState,
  }) {
    return MovieDetailState(
      mediaDetailModel ?? this.mediaDetailModel,
      movieDetailState ?? this.movieDetailState,
    );
  }

  @override
  List<Object?> get props => [mediaDetailModel, movieDetailState];
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

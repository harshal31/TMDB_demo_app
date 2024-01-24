import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/media_detail_api_service.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail_model.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

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
    final response = await apiCall(
      () => _movieDetailApiService.fetchMediaDetail(
        mediaType,
        typeId,
        language,
        ApiKey.appendToMediaResponse,
      ),
    );

    return response.fold((l) => left(l), (r) {
      model = model.copyWith(
        mediaDetail: r,
        mediaAccountState: r?.accountStates,
        mediaCredits: r?.credits,
        mediaExternalId: r?.externalIds,
        mediaImages: r?.images,
        mediaKeywords: r?.keywords,
        mediaRecommendations: r?.recommendations,
        mediaReviews: r?.reviews,
        mediaTranslations: r?.translations,
        mediaVideos: r?.videos,
      );
      return right(model);
    });
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

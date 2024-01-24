import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/media_detail_api_service.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail_model.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class TvDetailUseCase {
  final MediaDetailApiService _movieDetailApiService;

  const TvDetailUseCase(this._movieDetailApiService);

  Future<Either<ErrorResponse, MediaDetailModel>> fetchTvSeriesDetail(
    String typeId,
    String mediaType,
    String sessionId, {
    String language = ApiKey.defaultLanguage,
    int page = 1,
  }) async {
    MediaDetailModel model = MediaDetailModel();
    final response = await apiCall(
      () => _movieDetailApiService.fetchMediaDetail(
          mediaType, typeId, language, ApiKey.appendToMediaResponse),
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

class TvDetailState with EquatableMixin {
  final MediaDetailModel mediaDetailModel;
  final TvDetailStatus tvDetailState;

  TvDetailState(this.mediaDetailModel, this.tvDetailState);

  factory TvDetailState.initial() {
    return TvDetailState(
      MediaDetailModel(),
      TvDetailNone(),
    );
  }

  TvDetailState copyWith({
    MediaDetailModel? mediaDetailModel,
    TvDetailStatus? tvDetailState,
  }) {
    return TvDetailState(
      mediaDetailModel ?? this.mediaDetailModel,
      tvDetailState ?? this.tvDetailState,
    );
  }

  @override
  List<Object?> get props => [mediaDetailModel, tvDetailState];
}

sealed class TvDetailStatus with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class TvDetailNone extends TvDetailStatus {}

class TvDetailLoading extends TvDetailStatus {}

class TvDetailSuccess extends TvDetailStatus {}

class TvDetailFailure extends TvDetailStatus {
  final ErrorResponse errorResponse;

  TvDetailFailure(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}

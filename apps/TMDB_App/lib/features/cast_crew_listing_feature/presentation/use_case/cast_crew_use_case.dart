import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/app_constant.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/data/cast_crew_listing_api_service.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/data/media_grouping.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_credits.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_images.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class CastCrewUseCase {
  final CastCrewListingApiService castCrewListingApiService;

  CastCrewUseCase(this.castCrewListingApiService);

  Future<Either<ErrorResponse, MediaDetail>> fetchMediaCredits(
    bool isMovies,
    String mediaId, {
    String language = ApiKey.defaultLanguage,
    String appendResponse = ApiKey.castCrewAppendToResponse,
  }) async {
    final response = await apiCall(
      () => castCrewListingApiService.fetchMediaDetail(
        isMovies ? ApiKey.movie : ApiKey.tv,
        mediaId,
        language,
        appendResponse,
      ),
    );

    return response.fold((l) => left(l), (r) {
      return right(r);
    });
  }
}

class CastCrewState with EquatableMixin {
  final MediaDetail? mediaDetail;
  final CastCrewStatus castCrewStatus;
  final TmdbMediaState tmdbMediaState;
  final Map<String, List<Crew>> groupCrew;

  CastCrewState(
    this.mediaDetail,
    this.castCrewStatus,
    this.groupCrew,
    this.tmdbMediaState,
  );

  factory CastCrewState.initial() {
    return CastCrewState(null, CastCrewNone(), {}, TmdbMediaState.initial());
  }

  CastCrewState copyWith({
    MediaDetail? mediaDetail,
    CastCrewStatus? castCrewStatus,
    Map<String, List<Crew>>? groupCrew,
    TmdbMediaState? tmdbMediaState,
  }) {
    return CastCrewState(
      mediaDetail ?? this.mediaDetail,
      castCrewStatus ?? this.castCrewStatus,
      groupCrew ?? this.groupCrew,
      tmdbMediaState ?? this.tmdbMediaState,
    );
  }

  @override
  List<Object?> get props => [
        mediaDetail,
        castCrewStatus,
        groupCrew,
        tmdbMediaState,
      ];
}

sealed class CastCrewStatus with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class CastCrewNone extends CastCrewStatus {}

class CastCrewLoading extends CastCrewStatus {}

class CastCrewSuccess extends CastCrewStatus {}

class CastCrewError extends CastCrewStatus {
  final String error;

  CastCrewError(this.error);

  @override
  List<Object?> get props => [error];
}

class TmdbMediaState with EquatableMixin {
  final MediaDetail? mediaDetail;
  final GroupVideos groupVideos;
  final List<Backdrops> backdrops;
  final List<Posters> posters;
  final TmdbMediaStatus tmdbMediaStatus;
  final String currentPopupState;

  TmdbMediaState({
    required this.mediaDetail,
    required this.groupVideos,
    required this.backdrops,
    required this.posters,
    required this.tmdbMediaStatus,
    required this.currentPopupState,
  });

  factory TmdbMediaState.initial() {
    return TmdbMediaState(
      mediaDetail: null,
      groupVideos: GroupVideos.initial(),
      backdrops: [],
      posters: [],
      tmdbMediaStatus: TmdbFilterDone(),
      currentPopupState: AppConstant.all,
    );
  }

  TmdbMediaState copyWith({
    MediaDetail? mediaDetail,
    GroupVideos? groupVideos,
    List<Backdrops>? backdrops,
    List<Posters>? posters,
    TmdbMediaStatus? tmdbMediaStatus,
    String? currentPopupState,
  }) {
    return TmdbMediaState(
      mediaDetail: mediaDetail ?? this.mediaDetail,
      groupVideos: groupVideos ?? this.groupVideos,
      backdrops: backdrops ?? this.backdrops,
      posters: posters ?? this.posters,
      tmdbMediaStatus: tmdbMediaStatus ?? this.tmdbMediaStatus,
      currentPopupState: currentPopupState ?? this.currentPopupState,
    );
  }

  @override
  List<Object?> get props => [
        mediaDetail,
        groupVideos,
        backdrops,
        posters,
        tmdbMediaStatus,
        currentPopupState,
      ];
}

sealed class TmdbMediaStatus with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class TmdbFilterProcessing extends TmdbMediaStatus {}

class TmdbFilterDone extends TmdbMediaStatus {}

class TmdbFilterNone extends TmdbMediaStatus {}

class TmdbNoDataPresent extends TmdbMediaStatus {}

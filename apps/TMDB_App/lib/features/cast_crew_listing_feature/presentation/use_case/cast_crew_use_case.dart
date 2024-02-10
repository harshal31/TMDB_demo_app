import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/data/cast_crew_listing_api_service.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_credits.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class CastCrewUseCase {
  final CastCrewListingApiService castCrewListingApiService;

  CastCrewUseCase(this.castCrewListingApiService);

  Future<Either<ErrorResponse, MediaDetail>> fetchMediaCredits(
    bool isMovies,
    String mediaId, {
    String language = ApiKey.defaultLanguage,
  }) async {
    final response = await apiCall(
      () => castCrewListingApiService.fetchMediaDetail(
        isMovies ? ApiKey.movie : ApiKey.tv,
        mediaId,
        language,
        ApiKey.castCrewAppendToResponse,
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
  final Map<String, List<Crew>> groupCrew;

  CastCrewState(
    this.mediaDetail,
    this.castCrewStatus,
    this.groupCrew,
  );

  factory CastCrewState.initial() {
    return CastCrewState(null, CastCrewNone(), {});
  }

  CastCrewState copyWith({
    MediaDetail? mediaDetail,
    CastCrewStatus? castCrewStatus,
    Map<String, List<Crew>>? groupCrew,
  }) {
    return CastCrewState(
      mediaDetail ?? this.mediaDetail,
      castCrewStatus ?? this.castCrewStatus,
      groupCrew ?? this.groupCrew,
    );
  }

  @override
  List<Object?> get props => [
        mediaDetail,
        castCrewStatus,
        groupCrew,
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

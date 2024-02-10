import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/data/cast_crew_listing_api_service.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_credits.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class CastCrewUseCase {
  final CastCrewListingApiService castCrewListingApiService;

  CastCrewUseCase(this.castCrewListingApiService);

  Future<Either<ErrorResponse, MediaCredits>> fetchMediaCredits(
    bool isMovies,
    String mediaId, {
    String language = ApiKey.defaultLanguage,
  }) async {
    final result = await apiCall(
      () => castCrewListingApiService.getMediaCredits(
        isMovies ? ApiKey.movie : ApiKey.tv,
        mediaId,
        language,
      ),
    );

    return result.fold((l) => left(l), (r) => right(r));
  }
}

class CastCrewState with EquatableMixin {
  final MediaCredits? mediaCredit;
  final CastCrewStatus castCrewStatus;
  final Map<String, List<Crew>> groupCrew;

  CastCrewState(
    this.mediaCredit,
    this.castCrewStatus,
    this.groupCrew,
  );

  factory CastCrewState.initial() {
    return CastCrewState(null, CastCrewNone(), {});
  }

  CastCrewState copyWith({
    MediaCredits? mediaCredit,
    CastCrewStatus? castCrewStatus,
    Map<String, List<Crew>>? groupCrew,
  }) {
    return CastCrewState(
      mediaCredit ?? this.mediaCredit,
      castCrewStatus ?? this.castCrewStatus,
      groupCrew ?? this.groupCrew,
    );
  }

  @override
  List<Object?> get props => [
        mediaCredit,
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

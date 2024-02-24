import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/app_constant.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/data/media_grouping.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';

class CastCrewCubit extends Cubit<CastCrewState> {
  final CastCrewUseCase castCrewCubitUseCase;

  CastCrewCubit(this.castCrewCubitUseCase) : super(CastCrewState.initial());

  void fetchMediaDetails(
    bool isMovies,
    String mediaId, {
    MediaDetail? mediaDetail = null,
    CastCrewType castCrewType = CastCrewType.none,
  }) async {
    if (mediaDetail != null) {
      emit(
        state.copyWith(
          castCrewStatus: CastCrewSuccess(),
          mediaDetail: mediaDetail,
          groupCrew:
              castCrewType == CastCrewType.crew ? mediaDetail.credits?.groupByDepartment() : null,
          tmdbMediaState: state.tmdbMediaState.copyWith(
            groupVideos: castCrewType == CastCrewType.videos
                ? state.tmdbMediaState.groupVideos
                    .copyWith(groupVideos: mediaDetail.videos?.groupVideosByType())
                : GroupVideos.initial(),
            posters: castCrewType == CastCrewType.posters ? mediaDetail.images?.posters : [],
            backdrops: castCrewType == CastCrewType.backDrops ? mediaDetail.images?.backdrops : [],
            tmdbMediaStatus: _getTmdbStatus(castCrewType, mediaDetail),
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(castCrewStatus: CastCrewLoading()),
    );

    final result = await castCrewCubitUseCase.fetchMediaCredits(
      isMovies,
      mediaId,
      appendResponse: _getAppendResponseBasedOnType(castCrewType),
      language: "",
    );

    result.fold((l) {
      emit(
        state.copyWith(castCrewStatus: CastCrewError(l.errorMessage)),
      );
    }, (r) {
      if ((r.credits?.cast?.isEmpty ?? false) && (r.credits?.crew?.isEmpty ?? false)) {
        emit(
          state.copyWith(castCrewStatus: CastCrewError("No Cast and crew available")),
        );
        return;
      }

      emit(
        state.copyWith(
          castCrewStatus: CastCrewSuccess(),
          mediaDetail: r,
          groupCrew: castCrewType == CastCrewType.crew ? r.credits?.groupByDepartment() : null,
          tmdbMediaState: state.tmdbMediaState.copyWith(
            groupVideos: castCrewType == CastCrewType.videos
                ? state.tmdbMediaState.groupVideos
                    .copyWith(groupVideos: r.videos?.groupVideosByType())
                : GroupVideos.initial(),
            posters: castCrewType == CastCrewType.posters ? r.images?.posters : [],
            backdrops: castCrewType == CastCrewType.backDrops ? r.images?.backdrops : [],
            tmdbMediaStatus: _getTmdbStatus(castCrewType, r),
          ),
        ),
      );
    });
  }

  String _getAppendResponseBasedOnType(CastCrewType castCrewType) {
    if (castCrewType == CastCrewType.crew) {
      return ApiKey.castCrewAppendToResponse;
    }
    if (castCrewType == CastCrewType.videos) {
      return ApiKey.videosAppendToResponse;
    }

    if (castCrewType == CastCrewType.posters || castCrewType == CastCrewType.backDrops) {
      return ApiKey.imagesAppendToResponse;
    }

    return "";
  }

  TmdbMediaStatus _getTmdbStatus(CastCrewType castCrewType, MediaDetail r) {
    if (castCrewType == CastCrewType.videos && (r.videos?.results?.isEmpty ?? false)) {
      return TmdbNoDataPresent();
    }

    if (castCrewType == CastCrewType.posters && (r.images?.posters?.isEmpty ?? false)) {
      return TmdbNoDataPresent();
    }

    if (castCrewType == CastCrewType.backDrops && (r.images?.backdrops?.isEmpty ?? false)) {
      return TmdbNoDataPresent();
    }

    return state.tmdbMediaState.tmdbMediaStatus;
  }

  void filterDataBasedOnType(CastCrewType castCrewType, String type) async {
    emit(
      state.copyWith(
        tmdbMediaState: state.tmdbMediaState.copyWith(tmdbMediaStatus: TmdbFilterProcessing()),
      ),
    );

    if (castCrewType == CastCrewType.videos) {
      final groupVideos = state.tmdbMediaState.copyWith(
          groupVideos: state.tmdbMediaState.groupVideos.copyWith(
        currentGroupVideos: type == AppConstant.all
            ? state.tmdbMediaState.groupVideos.groupVideos
            : state.tmdbMediaState.groupVideos.getVideosBasedOnProvidedType(type),
      ));
      emit(
        state.copyWith(
          tmdbMediaState: state.tmdbMediaState.copyWith(
            tmdbMediaStatus: TmdbFilterDone(),
            groupVideos: groupVideos.groupVideos,
            currentPopupState: type,
          ),
        ),
      );
      return;
    }
  }
}

enum CastCrewType { videos, crew, posters, backDrops, none }

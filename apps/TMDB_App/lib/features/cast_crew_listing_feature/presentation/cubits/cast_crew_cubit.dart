import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';

class CastCrewCubit extends Cubit<CastCrewState> {
  final CastCrewUseCase castCrewCubitUseCase;

  CastCrewCubit(this.castCrewCubitUseCase) : super(CastCrewState.initial());

  void fetchMediaCredits(bool isMovies, String mediaId) async {
    emit(
      state.copyWith(castCrewStatus: CastCrewLoading()),
    );

    final result = await castCrewCubitUseCase.fetchMediaCredits(isMovies, mediaId);

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
          groupCrew: r.credits?.groupByDepartment(),
        ),
      );
    });
  }
}

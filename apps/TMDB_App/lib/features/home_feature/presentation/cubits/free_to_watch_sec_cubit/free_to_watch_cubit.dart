import 'package:common_widgets/widgets/code_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/movies_advance_filter_use.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/tv_advance_filter_use_case.dart';

class FreeToWatchCubit extends Cubit<AdvanceFilterState> {
  final MoviesAdvanceFilterUseCase _moviesAdvanceFilterUseCase;
  final TvAdvanceFilterUseCase _tvAdvanceFilterUseCase;
  int latestApiCall = 0;

  FreeToWatchCubit(this._moviesAdvanceFilterUseCase, this._tvAdvanceFilterUseCase)
      : super(AdvanceFilterState.initial());

  void fetchFreeResults(int pos) async {
    emit(
      state.copyWith(
        latestStatus: AdvanceFilterStatusLoading(generateUniqueKey()),
        pos: pos,
        error: null,
      ),
    );

    final currentCall = ++latestApiCall;
    final result = pos == 0
        ? await _moviesAdvanceFilterUseCase.advanceMovieFilter(
            withWatchMonetizationTypes: ApiKey.freeToWatchValue,
          )
        : await _tvAdvanceFilterUseCase.advanceTvFilter(
            withWatchMonetizationTypes: ApiKey.freeToWatchValue,
          );

    result.fold((l) {
      if (currentCall == latestApiCall) {
        emit(
          state.copyWith(
            latestStatus: AdvanceFilterStatusDone(generateUniqueKey()),
            pos: pos,
            error: l.errorMessage,
          ),
        );
      }
    }, (r) {
      if (currentCall == latestApiCall) {
        emit(
          state.copyWith(
            latestStatus: AdvanceFilterStatusDone(generateUniqueKey()),
            results: r.latestData ?? [],
            pos: pos,
            error: null,
          ),
        );
      }
    });
  }
}

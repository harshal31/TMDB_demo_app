import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/trending_use_case.dart';

class TrendingCubit extends Cubit<TrendingState> {
  final TrendingUseCase _trendingUseCase;

  TrendingCubit(this._trendingUseCase) : super(TrendingState.initial());

  void fetchTrendingResults(
    int? pos, {
    bool? switchState,
    String timeWindow = ApiKey.day,
  }) async {
    emit(state.copyWith(trendingStatus: TrendingLoading(UniqueKey().toString())));
    final result = await _trendingUseCase.getTrendingResult(pos!, timeWindow);

    result.fold((l) {
      emit(state.copyWith(trendingStatus: TrendingDone(UniqueKey().toString())));
    }, (r) {
      emit(state.copyWith(
          trendingResult: r, trendingStatus: TrendingDone(UniqueKey().toString())));
    });
  }
}

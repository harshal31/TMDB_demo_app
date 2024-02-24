import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/hive_key.dart';
import 'package:tmdb_app/data_storage/hive_manager.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/user_pref_use_case.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/use_cases/tv_detail_use_case.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  final TvDetailUseCase _tvDetailUseCase;
  final UserPrefUseCase _userPrefUseCase;

  TvDetailCubit(
    this._tvDetailUseCase,
    this._userPrefUseCase,
  ) : super(TvDetailState.initial());

  void fetchTvSeriesDetails(String seriesId) async {
    emit(state.copyWith(tvDetailState: TvDetailLoading()));
    final sessionId = await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);
    final result = await _tvDetailUseCase.fetchTvSeriesDetail(
      seriesId,
      ApiKey.tv,
      sessionId,
      language: "",
    );

    result.fold((l) {
      emit(state.copyWith(tvDetailState: TvDetailFailure(l)));
    }, (r) {
      emit(state.copyWith(mediaDetailModel: r, tvDetailState: TvDetailSuccess()));
    });
  }

  void saveUserPreference(
    int? mediaId,
    String userKey,
    bool prefValue,
  ) async {
    final sessionId = await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);
    _userPrefUseCase.saveUserPref(sessionId, ApiKey.tv, mediaId ?? 0, userKey, prefValue);
  }

  void addMediaRating(int? mediaId, double rating) async {
    final sessionId = await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);
    _userPrefUseCase.addRating(sessionId, ApiKey.tv, rating, mediaId ?? 0);
  }
}

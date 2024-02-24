import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/hive_key.dart';
import 'package:tmdb_app/data_storage/hive_manager.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/movie_detail_use_case.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/user_pref_use_case.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieDetailUseCase _movieDetailUseCase;
  final UserPrefUseCase _userPrefUseCase;

  MovieDetailCubit(
    this._movieDetailUseCase,
    this._userPrefUseCase,
  ) : super(MovieDetailState.initial());

  void fetchMovieDetails(String movieId) async {
    emit(state.copyWith(movieDetailState: MovieDetailLoading()));
    final sessionId = await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);
    final result = await _movieDetailUseCase.fetchMovieDetails(
      movieId,
      ApiKey.movie,
      sessionId,
      language: "",
    );

    result.fold((l) {
      emit(state.copyWith(movieDetailState: MovieDetailFailure(l)));
    }, (r) {
      emit(state.copyWith(mediaDetailModel: r, movieDetailState: MovieDetailSuccess()));
    });
  }

  void saveUserPreference(
    int? mediaId,
    String userKey,
    bool prefValue,
  ) async {
    final sessionId = await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);
    _userPrefUseCase.saveUserPref(sessionId, ApiKey.movie, mediaId ?? 0, userKey, prefValue);
  }

  void addMediaRating(int? mediaId, double rating) async {
    final sessionId = await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);
    _userPrefUseCase.addRating(sessionId, ApiKey.movie, rating, mediaId ?? 0);
  }
}

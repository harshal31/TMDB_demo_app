import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/hive_key.dart';
import 'package:tmdb_app/data_storage/hive_manager.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/movie_detail_use_case.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieDetailUseCase _movieDetailUseCase;

  MovieDetailCubit(this._movieDetailUseCase) : super(MovieDetailState.initial());

  void fetchMovieDetails(String movieId) async {
    emit(state.copyWith(movieDetailState: MovieDetailLoading()));
    final sessionId = await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);
    final result = await _movieDetailUseCase.fetchMovieDetails(movieId, ApiKey.movie, sessionId);

    result.fold((l) {
      emit(state.copyWith(movieDetailState: MovieDetailFailure(l)));
    }, (r) {
      emit(state.copyWith(movieDetailModel: r, movieDetailState: MovieDetailSuccess()));
    });
  }
}

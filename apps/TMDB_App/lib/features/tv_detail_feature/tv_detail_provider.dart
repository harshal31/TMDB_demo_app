import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/media_detail_api_service.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/movie_detail_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/position_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/movie_detail_use_case.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/user_pref_use_case.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/use_cases/tv_detail_use_case.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class MovieDetailProvider {
  static void register(GetIt getIt) {
    getIt
      ..registerFactory<TvDetailUseCase>(
        () => TvDetailUseCase(getIt()),
      )
      ..registerFactory<MovieDetailCubit>(
        () => MovieDetailCubit(getIt(), getIt()),
      );
  }
}

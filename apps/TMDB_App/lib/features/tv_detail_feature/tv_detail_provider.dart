import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/cubits/tv_detail_cubit.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/use_cases/tv_detail_use_case.dart';

class TvDetailProvider {
  static void register(GetIt getIt) {
    getIt
      ..registerFactory<TvDetailUseCase>(
        () => TvDetailUseCase(getIt()),
      )
      ..registerFactory<TvDetailCubit>(
        () => TvDetailCubit(getIt(), getIt()),
      );
  }
}

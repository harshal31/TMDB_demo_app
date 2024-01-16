import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/home_feature/data/home_api_service.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/latest_sec_cubit/latest_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/latest_sec_cubit/latest_position_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/trending_sec_cubit/trending_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/cubits/trending_sec_cubit/trending_position_cubit.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/trending_use_case.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class HomeProviders {
  static void register(GetIt getIt) {
    getIt
      ..registerFactory<HomeApiService>(
        () => HomeApiService(getIt<DioManager>().dio),
      )
      ..registerFactory<TrendingUseCase>(
        () => TrendingUseCase(getIt()),
      )
      ..registerFactory<TrendingPositionCubit>(
        () => TrendingPositionCubit(),
      )
      ..registerFactory<TrendingCubit>(
        () => TrendingCubit(getIt()),
      )
      ..registerFactory<LatestPositionCubit>(
        () => LatestPositionCubit(),
      )
      ..registerFactory<LatestCubit>(
        () => LatestCubit(getIt()),
      );
  }
}

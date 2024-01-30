import "package:common_widgets/localizations/localized_extension.dart";
import "package:common_widgets/theme/size_detector.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:tmdb_app/features/home_feature/data/home_api_service.dart";
import "package:tmdb_app/features/home_feature/presentation/cubits/free_to_watch_sec_cubit/free_to_watch_cubit.dart";
import "package:tmdb_app/features/home_feature/presentation/cubits/latest_sec_cubit/latest_cubit.dart";
import "package:tmdb_app/features/home_feature/presentation/cubits/latest_sec_cubit/latest_position_cubit.dart";
import "package:tmdb_app/features/home_feature/presentation/cubits/trending_sec_cubit/trending_cubit.dart";
import "package:tmdb_app/features/home_feature/presentation/cubits/trending_sec_cubit/trending_position_cubit.dart";
import "package:tmdb_app/features/home_feature/presentation/screens/mobile/home_mobile_screen.dart";
import "package:tmdb_app/features/home_feature/presentation/screens/tablet/home_tablet_screen.dart";
import "package:tmdb_app/features/home_feature/presentation/screens/web/home_web_screen.dart";
import "package:tmdb_app/features/home_feature/presentation/use_case/latest_use_case.dart";
import "package:tmdb_app/features/home_feature/presentation/use_case/movies_advance_filter_use.dart";
import "package:tmdb_app/features/home_feature/presentation/use_case/trending_use_case.dart";
import "package:tmdb_app/features/home_feature/presentation/use_case/tv_advance_filter_use_case.dart";
import "package:tmdb_app/network/dio_manager.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<HomeApiService>(
          create: (_) => HomeApiService(GetIt.instance.get<DioManager>().dio),
        ),
        RepositoryProvider<TrendingUseCase>(
          create: (c) => TrendingUseCase(c.read()),
        ),
        RepositoryProvider<LatestUseCase>(
          create: (c) => LatestUseCase(c.read()),
        ),
        RepositoryProvider<MoviesAdvanceFilterUseCase>(
          create: (c) => MoviesAdvanceFilterUseCase(c.read()),
        ),
        RepositoryProvider<TvAdvanceFilterUseCase>(
          create: (c) => TvAdvanceFilterUseCase(c.read()),
        ),
        BlocProvider(
          create: (c) => TrendingCubit(c.read())..fetchTrendingResults(0),
        ),
        BlocProvider(
          create: (c) => TrendingPositionCubit(),
        ),
        BlocProvider(
          create: (c) => LatestCubit(c.read())
            ..fetchLatestResults(
              true,
              context.tr.nowPlaying,
            ),
        ),
        BlocProvider(
          create: (c) => LatestPositionCubit(),
        ),
        BlocProvider(
          create: (c) => FreeToWatchCubit(c.read(), c.read())..fetchFreeResults(0),
        )
      ],
      child: SafeArea(
        child: Scaffold(
          body: SizeDetector(
            mobileBuilder: () => const HomeMobileScreen(),
            tabletBuilder: () => const HomeTabletScreen(),
            desktopBuilder: () => const HomeWebScreen(),
          ),
        ),
      ),
    );
  }
}

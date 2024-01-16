import "package:common_widgets/theme/size_detector.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:tmdb_app/features/home_feature/presentation/cubits/latest_sec_cubit/latest_cubit.dart";
import "package:tmdb_app/features/home_feature/presentation/cubits/latest_sec_cubit/latest_position_cubit.dart";
import "package:tmdb_app/features/home_feature/presentation/cubits/trending_sec_cubit/trending_cubit.dart";
import "package:tmdb_app/features/home_feature/presentation/cubits/trending_sec_cubit/trending_position_cubit.dart";
import "package:tmdb_app/features/home_feature/presentation/screens/mobile/home_mobile_screen.dart";
import "package:tmdb_app/features/home_feature/presentation/screens/tablet/home_tablet_screen.dart";
import "package:tmdb_app/features/home_feature/presentation/screens/web/home_web_screen.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) => GetIt.instance.get<TrendingCubit>()..fetchTrendingResults(0),
        ),
        BlocProvider(
          create: (c) => GetIt.instance.get<TrendingPositionCubit>(),
        ),
        BlocProvider(
          create: (c) => GetIt.instance.get<LatestCubit>()..fetchLatestResults(),
        ),
        BlocProvider(
          create: (c) => GetIt.instance.get<LatestPositionCubit>(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SizeDetector(
            mobileBuilder: () => HomeMobileScreen(),
            tabletBuilder: () => HomeTabletScreen(),
            desktopBuilder: () => HomeWebScreen(),
          ),
        ),
      ),
    );
  }
}

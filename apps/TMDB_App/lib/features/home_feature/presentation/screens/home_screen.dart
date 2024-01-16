import "package:common_widgets/theme/size_detector.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:tmdb_app/features/home_feature/presentation/cubits/trending_cubit.dart";
import "package:tmdb_app/features/home_feature/presentation/cubits/trending_position_cubit.dart";
import "package:tmdb_app/features/home_feature/presentation/screens/mobile/home_mobile.dart";
import "package:tmdb_app/features/home_feature/presentation/screens/tablet/home_tablet.dart";
import "package:tmdb_app/features/home_feature/presentation/screens/web/home_web.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) => GetIt.instance.get<TrendingCubit>()..getTrendingResult(0),
        ),
        BlocProvider(
          create: (c) => GetIt.instance.get<TrendingPositionCubit>(),
        )
      ],
      child: SafeArea(
        child: Scaffold(
          body: SizeDetector(
            mobileBuilder: () {
              return HomeMobile();
            },
            tabletBuilder: () {
              return HomeTablet();
            },
            desktopBuilder: () {
              return HomeWeb();
            },
          ),
        ),
      ),
    );
  }
}

import 'package:common_widgets/theme/size_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/position_cubit.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/cubits/tv_detail_cubit.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/screens/mobile/tv_detail_mobile_screen.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/screens/tablet/tv_detail_tablet_screen.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/screens/web/tv_detail_web_screen.dart';

class TvDetailScreen extends StatelessWidget {
  final String seriesId;

  const TvDetailScreen({
    super.key,
    required this.seriesId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) => GetIt.instance.get<TvDetailCubit>()..fetchTvSeriesDetails(seriesId),
        ),
        BlocProvider(
          create: (c) => GetIt.instance.get<PositionCubit>(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SizeDetector(
            mobileBuilder: () => const TvDetailMobileScreen(),
            tabletBuilder: () => const TvDetailTabletScreen(),
            desktopBuilder: () => const TvDetailWebScreen(),
          ),
        ),
      ),
    );
  }
}
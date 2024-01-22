import 'package:common_widgets/theme/size_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/movie_detail_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/position_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/screens/mobile/movie_detail_mobile_screen.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/screens/tablet/movie_detail_tablet_screen.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/screens/web/movie_detail_web_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final String movieId;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) => GetIt.instance.get<MovieDetailCubit>()..fetchMovieDetails(movieId),
        ),
        BlocProvider(
          create: (c) => GetIt.instance.get<PositionCubit>(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SizeDetector(
            mobileBuilder: () => MovieDetailMobileScreen(),
            tabletBuilder: () => MovieDetailTabletScreen(),
            desktopBuilder: () => MovieDetailWebScreen(),
          ),
        ),
      ),
    );
  }
}

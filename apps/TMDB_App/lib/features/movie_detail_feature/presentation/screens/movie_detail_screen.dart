import 'package:tmdb_app/utils/size_detector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/media_detail_api_service.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/movie_detail_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/position_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/screens/mobile/movie_detail_mobile_screen.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/screens/tablet/movie_detail_tablet_screen.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/screens/web/movie_detail_web_screen.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/movie_detail_use_case.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/user_pref_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';

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
        RepositoryProvider<MediaDetailApiService>(
          create: (_) => MediaDetailApiService(GetIt.instance.get<DioManager>().dio),
        ),
        RepositoryProvider<MovieDetailUseCase>(
          create: (c) => MovieDetailUseCase(c.read()),
        ),
        RepositoryProvider<UserPrefUseCase>(
          create: (c) => UserPrefUseCase(c.read()),
        ),
        BlocProvider(
          create: (c) => MovieDetailCubit(c.read(), c.read())..fetchMovieDetails(movieId),
        ),
        BlocProvider(
          create: (c) => PositionCubit(0),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const TmdbAppBar(
            shouldDisplayBack: !kIsWeb,
          ),
          body: SizeDetector(
            mobileBuilder: () => const MovieDetailMobileScreen(),
            tabletBuilder: () => const MovieDetailTabletScreen(),
            desktopBuilder: () => const MovieDetailWebScreen(),
          ),
        ),
      ),
    );
  }
}

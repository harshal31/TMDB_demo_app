import 'package:common_widgets/theme/size_detector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/media_detail_api_service.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/position_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/user_pref_use_case.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/cubits/tv_detail_cubit.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/screens/mobile/tv_detail_mobile_screen.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/screens/tablet/tv_detail_tablet_screen.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/screens/web/tv_detail_web_screen.dart';
import 'package:tmdb_app/features/tv_detail_feature/presentation/use_cases/tv_detail_use_case.dart';
import 'package:tmdb_app/network/dio_manager.dart';

import '../../../tmdb_widgets/tmdb_app_bar.dart';

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
        RepositoryProvider<MediaDetailApiService>(
          create: (_) => MediaDetailApiService(GetIt.instance.get<DioManager>().dio),
        ),
        RepositoryProvider<TvDetailUseCase>(
          create: (c) => TvDetailUseCase(c.read()),
        ),
        RepositoryProvider<UserPrefUseCase>(
          create: (c) => UserPrefUseCase(c.read()),
        ),
        BlocProvider(
          create: (c) => TvDetailCubit(c.read(), c.read())..fetchTvSeriesDetails(seriesId),
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
            mobileBuilder: () => const TvDetailMobileScreen(),
            tabletBuilder: () => const TvDetailTabletScreen(),
            desktopBuilder: () => const TvDetailWebScreen(),
          ),
        ),
      ),
    );
  }
}

import 'package:common_widgets/theme/size_detector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/data/cast_crew_listing_api_service.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/cubits/cast_crew_cubit.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/screens/mobile/cast_crew_mobile_screen.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/screens/web_tablet/cast_crew_screen_web_tab_screen.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class CastCrewScreen extends StatelessWidget {
  final bool isMovies;
  final String mediaId;

  const CastCrewScreen({
    super.key,
    required this.isMovies,
    required this.mediaId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<CastCrewListingApiService>(
          create: (_) => CastCrewListingApiService(GetIt.instance.get<DioManager>().dio),
        ),
        RepositoryProvider<CastCrewUseCase>(
          create: (c) => CastCrewUseCase(c.read()),
        ),
        BlocProvider(
          create: (c) => CastCrewCubit(c.read())..fetchMediaCredits(isMovies, mediaId),
        )
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const TmdbAppBar(
            shouldDisplayBack: !kIsWeb,
          ),
          body: SizeDetector(
            mobileBuilder: () => CastCrewMobileScreen(
              isMovies: isMovies,
            ),
            tabletBuilder: () => CastCrewWebTabScreen(
              isMovies: isMovies,
            ),
            desktopBuilder: () => CastCrewWebTabScreen(
              isMovies: isMovies,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:common_widgets/theme/size_detector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/data/cast_crew_listing_api_service.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/cubits/cast_crew_cubit.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';
import 'package:tmdb_app/features/tmdb_media_feature/screens/video_listing_screen/screens/desktop_tab/tmdb_youtube_media_listing_impl.dart';
import 'package:tmdb_app/features/tmdb_media_feature/screens/video_listing_screen/screens/mobile/tmdb_youtube_media_listing_mobile_impl.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class TmdbYoutubeMediaListingScreen extends StatelessWidget {
  final bool isMovies;
  final String mediaId;

  const TmdbYoutubeMediaListingScreen({
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
          create: (c) => CastCrewCubit(c.read())
            ..fetchMediaDetails(
              isMovies,
              mediaId,
              castCrewType: CastCrewType.videos,
            ),
        )
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const TmdbAppBar(
            shouldDisplayBack: !kIsWeb,
          ),
          body: SizeDetector(
            desktopBuilder: () => TmdbYoutubeMediaListingImpl(
              isMovies: isMovies,
              mediaId: mediaId,
            ),
            mobileBuilder: () => TmdbYoutubeMediaListingMobileImpl(
              isMovies: isMovies,
              mediaId: mediaId,
            ),
            tabletBuilder: () => TmdbYoutubeMediaListingImpl(
              isMovies: isMovies,
              mediaId: mediaId,
            ),
          ),
        ),
      ),
    );
  }
}

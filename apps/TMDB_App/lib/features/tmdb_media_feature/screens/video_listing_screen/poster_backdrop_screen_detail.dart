import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/data/cast_crew_listing_api_service.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/cubits/cast_crew_cubit.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/tmdb_media_feature/screens/video_listing_screen/poster_backdrop_screens/mobile/poster_backdrop_screen_detail_mobile.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class PosterBackdropScreenDetail extends StatelessWidget {
  final MediaDetail? mediaDetail;
  final String mediaId;
  final int gotToIndex;
  final bool isMovies;
  final bool isPosters;

  const PosterBackdropScreenDetail({
    super.key,
    required this.mediaDetail,
    required this.mediaId,
    required this.gotToIndex,
    required this.isMovies,
    required this.isPosters,
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
              castCrewType: isPosters ? CastCrewType.posters : CastCrewType.backDrops,
              mediaDetail: mediaDetail,
            ),
        )
      ],
      child: PosterBackdropScreenDetailMobile(
        isMovies: isMovies,
        mediaDetail: mediaDetail,
        gotToIndex: gotToIndex,
        isPosters: isPosters,
      ),
    );
  }
}

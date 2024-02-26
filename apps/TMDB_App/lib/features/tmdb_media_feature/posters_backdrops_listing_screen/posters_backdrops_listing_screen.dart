import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/data/cast_crew_listing_api_service.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/cubits/cast_crew_cubit.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/tmdb_media_feature/posters_backdrops_listing_screen/posters_backdrop_listing_screen_impl.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class PostersBackdropsListingScreen extends StatelessWidget {
  final MediaDetail? mediaDetail;
  final String mediaType;
  final String mediaId;
  final bool isMovies;
  final bool isPosters;

  const PostersBackdropsListingScreen({
    super.key,
    this.mediaDetail,
    required this.mediaId,
    required this.isMovies,
    required this.isPosters,
    required this.mediaType,
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
      child: SafeArea(
        child: Scaffold(
          appBar: const TmdbAppBar(
            shouldDisplayBack: !kIsWeb,
          ),
          body: PostersBackdropsListingScreenImpl(
            isMovies: isMovies,
            mediaDetail: mediaDetail,
            isPosters: isPosters,
            mediaType: mediaType,
            mediaId: mediaId,
          ),
        ),
      ),
    );
  }
}

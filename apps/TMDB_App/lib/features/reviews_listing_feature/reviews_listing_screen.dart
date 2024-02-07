import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/reviews_listing_feature/cubit/reviews_listing_cubit.dart';
import 'package:tmdb_app/features/reviews_listing_feature/cubit/reviews_listing_use_case.dart';
import 'package:tmdb_app/features/reviews_listing_feature/data/reviews_listing_api_service.dart';
import 'package:tmdb_app/features/reviews_listing_feature/reviews_listing_screen_impl.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_app_bar.dart';
import 'package:tmdb_app/network/dio_manager.dart';

class ReviewsListingScreen extends StatelessWidget {
  final String mediaId;
  final MediaDetail? mediaDetail;
  final bool isMovies;

  const ReviewsListingScreen({
    super.key,
    required this.mediaId,
    required this.isMovies,
    this.mediaDetail,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<ReviewsListingApiService>(
          create: (_) => ReviewsListingApiService(GetIt.instance.get<DioManager>().dio),
        ),
        RepositoryProvider<ReviewsListingUseCase>(
          create: (c) => ReviewsListingUseCase(c.read()),
        ),
        BlocProvider(
          create: (c) => ReviewsListingCubit(c.read()),
        )
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: const TmdbAppBar(
            shouldDisplayBack: !kIsWeb,
          ),
          body: ReviewsListingScreenImpl(
            mediaId: mediaId,
            isMovies: isMovies,
            mediaDetail: mediaDetail,
          ),
        ),
      ),
    );
  }
}

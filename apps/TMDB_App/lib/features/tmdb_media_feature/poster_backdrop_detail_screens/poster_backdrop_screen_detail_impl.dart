import 'package:common_widgets/theme/theme_util.dart';
import 'package:common_widgets/widgets/lottie_loader.dart';
import 'package:common_widgets/widgets/tmdb_center_enlarge_carousal_slider.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/cubits/cast_crew_cubit.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';

class PosterBackdropScreenDetailImpl extends StatelessWidget {
  final MediaDetail? mediaDetail;
  final int gotToIndex;
  final bool isMovies;
  final bool isPosters;

  const PosterBackdropScreenDetailImpl({
    super.key,
    required this.mediaDetail,
    required this.gotToIndex,
    required this.isMovies,
    required this.isPosters,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastCrewCubit, CastCrewState>(
      builder: (context, state) {
        if (state.castCrewStatus is CastCrewLoading || state.castCrewStatus is CastCrewNone) {
          return const LinearLoader();
        }

        if (state.castCrewStatus is CastCrewError) {
          return Center(
            child: WrappedText(
              (state.castCrewStatus as CastCrewError).error,
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }

        return TmdbCenterEnlargeCarousalSlider(
          initialIndex: gotToIndex,
          images: isPosters
              ? state.tmdbMediaState.posters.map((e) => e.getOriginalImage()).toList()
              : state.tmdbMediaState.backdrops.map((e) => e.getImage()).toList(),
          onClose: () {
            GoRouter.of(context).pop();
          },
        );
      },
    );
  }
}

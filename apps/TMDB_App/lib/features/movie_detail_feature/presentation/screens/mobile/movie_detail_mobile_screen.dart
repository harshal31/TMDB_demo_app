import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/common_utils/time_conversion.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/custom_tab_bar.dart';
import 'package:common_widgets/widgets/dominant_color_from_image.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:common_widgets/widgets/lottie_loader.dart';
import 'package:common_widgets/widgets/tmdb_icon.dart';
import 'package:common_widgets/widgets/tmdb_user_score.dart';
import 'package:common_widgets/widgets/tooltip_rating.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/movie_detail_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/position_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/movie_detail_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_cast_list.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_media_view.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_recomendations%20.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_review.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_share.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_side_view.dart';

import '../../../../../routes/route_param.dart';
import '../../../../../utils/common_navigation.dart';

class MovieDetailMobileScreen extends StatelessWidget {
  const MovieDetailMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final positionCubit = context.read<PositionCubit>();
    final movieDetailCubit = context.read<MovieDetailCubit>();

    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (context, state) {
        if (state.movieDetailState is MovieDetailLoading ||
            state.movieDetailState is MovieDetailNone) {
          return const Center(
            child: LottieLoader(),
          );
        }

        if (state.movieDetailState is MovieDetailFailure) {
          return Center(
            child: WrappedText(
              (state.movieDetailState as MovieDetailFailure).errorResponse.errorMessage,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        final backdropImage = ExtendedImageCreator.getImage(
          state.mediaDetailModel.getBackdropImage(),
          width: MediaQuery.of(context).size.width * 0.7,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            bottomLeft: Radius.circular(6),
          ),
        );

        return CustomScrollView(
          scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 232,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          bottom: 0,
                          child: backdropImage,
                        ),
                        Positioned.fill(
                          child: DominantColorFromImage(
                            imageProvider: backdropImage.image,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ExtendedImageCreator(
                              imageUrl: state.mediaDetailModel.getPosterPath(),
                              width: 140,
                              height: 200,
                              shouldDisplayErrorImage: true,
                              fit: BoxFit.cover,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DominantColorFromImage(
                    imageProvider: backdropImage.image,
                    dominantChild: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        WrappedText(
                          "${state.mediaDetailModel.mediaDetail?.getActualName(true) ?? ""} ",
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        WrappedText(
                          state.mediaDetailModel.getReleaseYear(),
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        WrappedText(
                          textAlign: TextAlign.center,
                          state.mediaDetailModel.mediaDetail?.releaseDate.formatDateInMDYFormat ??
                              "",
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TmdbUserScore(
                          average: state.mediaDetailModel.mediaDetail?.voteAverage ?? 0.0,
                          voteCount: state.mediaDetailModel.mediaDetail?.voteCount,
                          circleSize: 50,
                          numberStyle: context.textTheme.titleMedium,
                          style: context.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Visibility(
                          visible: state.mediaDetailModel.genres().isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: WrappedText(
                              textAlign: TextAlign.center,
                              state.mediaDetailModel.genres(),
                              style: context.textTheme.titleSmall,
                            ),
                          ),
                        ),
                        WrappedText(
                          state.mediaDetailModel.mediaDetail?.runtime.formatTimeInHM ?? "",
                          style: context.textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TmdbIcon(
                              iconSize: 20,
                              icons: (Icons.favorite, Icons.favorite_outline_sharp),
                              isSelected:
                                  state.mediaDetailModel.mediaAccountState?.favorite ?? false,
                              selectedColor: Colors.red,
                              onSelection: (s) {
                                movieDetailCubit.saveUserPreference(
                                  state.mediaDetailModel.mediaDetail?.id,
                                  ApiKey.favorite,
                                  s,
                                );
                              },
                              hoverMessage: context.tr.markAsFavorite,
                            ),
                            const SizedBox(width: 16),
                            TmdbIcon(
                              iconSize: 20,
                              icons: (Icons.bookmark, Icons.bookmark_outline_sharp),
                              isSelected:
                                  state.mediaDetailModel.mediaAccountState?.watchlist ?? false,
                              selectedColor: Colors.red,
                              onSelection: (s) {
                                movieDetailCubit.saveUserPreference(
                                  state.mediaDetailModel.mediaDetail?.id,
                                  ApiKey.watchList,
                                  s,
                                );
                              },
                              hoverMessage: context.tr.addToWatchlist,
                            ),
                            const SizedBox(width: 16),
                            TooltipRating(
                              rating:
                                  state.mediaDetailModel.mediaAccountState?.getSafeRating() ?? 0.0,
                              iconSize: 20,
                              hoverMessage: context.tr.addToWatchlist,
                              onRatingUpdate: (rating) {
                                movieDetailCubit.addMediaRating(
                                  state.mediaDetailModel.mediaDetail?.id,
                                  rating,
                                );
                              },
                            ),
                          ],
                        ),
                        Visibility(
                          visible: state.mediaDetailModel.mediaDetail?.tagline?.isNotEmpty ?? false,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: WrappedText(
                              state.mediaDetailModel.mediaDetail?.tagline ?? "",
                              textAlign: TextAlign.center,
                              style: context.textTheme.titleSmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: context.colorTheme.onBackground.withOpacity(0.6)),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: state.mediaDetailModel.getWriterDirectorMapping().$1.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (ctx, index) => const Divider(indent: 20),
                                  itemCount:
                                      state.mediaDetailModel.getWriterDirectorMapping().$1.length,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (ctx, index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        WrappedText(
                                          state.mediaDetailModel
                                              .getWriterDirectorMapping()
                                              .$1[index],
                                          style: context.textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                        ),
                                        WrappedText(
                                          state.mediaDetailModel
                                              .getWriterDirectorMapping()
                                              .$2[index],
                                          style: context.textTheme.bodySmall,
                                          maxLines: 1,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverVisibility(
              visible: (state.mediaDetailModel.mediaDetail?.overview ?? "").isNotEmpty,
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      WrappedText(
                        context.tr.overview,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      WrappedText(
                        state.mediaDetailModel.mediaDetail?.overview ?? "",
                        style: context.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TmdbShare(
                      tmdbShareModel: state.mediaDetailModel.mediaExternalId,
                      mediaType: RouteParam.movie,
                    ),
                    const SizedBox(height: 16),
                    TmdbSideView(
                      keywordSpacing: 2.0,
                      mediaDetail: state.mediaDetailModel.mediaDetail,
                      keywords: state.mediaDetailModel.mediaKeywords?.keywords ?? [],
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: WrappedText(
                            context.tr.topBilledCast,
                            style:
                                context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 30,
                          ),
                          onPressed: () {
                            final id = state.mediaDetailModel.mediaDetail?.id;
                            CommonNavigation.redirectToCastScreen(
                              context,
                              mediaType: RouteParam.movie,
                              mediaId: id,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TmdbCastList(
                      model: state.mediaDetailModel.mediaCredits?.cast,
                      mediaDetail: state.mediaDetailModel.mediaDetail,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: WrappedText(
                            context.tr.reviews,
                            style:
                                context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Visibility(
                          visible:
                              state.mediaDetailModel.mediaReviews?.results?.isNotEmpty ?? false,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 30,
                            ),
                            onPressed: () {
                              final id = state.mediaDetailModel.mediaDetail?.id;
                              CommonNavigation.redirectToReviewsScreen(
                                context,
                                mediaType: RouteParam.movie,
                                mediaId: id,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TmdbReview(
                      result: state.mediaDetailModel.mediaReviews?.getSafeReview(),
                      mediaDetail: state.mediaDetailModel.mediaDetail,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: WrappedText(
                            context.tr.media,
                            style:
                                context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 30,
                          ),
                          onPressed: () {
                            if (positionCubit.state == 0) {
                              CommonNavigation.redirectToVideosScreen(
                                context,
                                mediaId: state.mediaDetailModel.mediaDetail?.id?.toString() ?? "",
                                mediaType: RouteParam.movie,
                              );
                              return;
                            }

                            if (positionCubit.state == 1) {}

                            if (positionCubit.state == 2) {}
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: CustomTabBar(
                        titles: [
                          context.tr.videos,
                          context.tr.backdrops,
                          context.tr.posters,
                        ],
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        selectedColor: context.colorTheme.primaryContainer,
                        onSelectedTab: (pos) {
                          positionCubit.updatePos(pos);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    BlocBuilder<PositionCubit, int>(
                      builder: (context, s) {
                        return TmdbMediaView(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 200,
                          mediaDetail: state.mediaDetailModel.mediaDetail,
                          pos: s,
                          videos: state.mediaDetailModel.mediaVideos?.results ?? [],
                          images: state.mediaDetailModel.mediaImages,
                          mediaType: RouteParam.movie,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    WrappedText(
                      context.tr.almostIdentical,
                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TmdbRecomendations(
                      recommendations: state.mediaDetailModel.similar?.results ?? [],
                      detail: state.mediaDetailModel.mediaDetail,
                      mediaType: RouteParam.movie,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    WrappedText(
                      context.tr.recommendations,
                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TmdbRecomendations(
                      recommendations: state.mediaDetailModel.mediaRecommendations?.results ?? [],
                      detail: state.mediaDetailModel.mediaDetail,
                      mediaType: RouteParam.movie,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

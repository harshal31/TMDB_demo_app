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
import 'package:tmdb_app/routes/route_param.dart';
import 'package:tmdb_app/utils/common_navigation.dart';

class MovieDetailTabletScreen extends StatelessWidget {
  const MovieDetailTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final positionCubit = context.read<PositionCubit>();
    final movieDetailCubit = context.read<MovieDetailCubit>();

    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (context, state) {
        if (state.movieDetailState is MovieDetailLoading ||
            state.movieDetailState is MovieDetailNone) {
          return const LinearLoader();
        }

        if (state.movieDetailState is MovieDetailFailure) {
          return Center(
            child: WrappedText(
              (state.movieDetailState as MovieDetailFailure).errorResponse.errorMessage,
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        final backdropImage = ExtendedImageCreator.getImage(
          state.mediaDetailModel.getBackdropImage(),
        );

        return CustomScrollView(
          scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 570,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: backdropImage,
                      ),
                    ),
                    Positioned.fill(
                      child: DominantColorFromImage(
                        imageProvider: backdropImage.image,
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            ExtendedImageCreator(
                              imageUrl: state.mediaDetailModel.getPosterPath(),
                              width: 300,
                              height: 450,
                              fit: BoxFit.cover,
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Center(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                              "${state.mediaDetailModel.mediaDetail?.getActualName(true) ?? ""} ",
                                          style: context.textTheme.headlineLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: state.mediaDetailModel.getReleaseYear(),
                                          style: context.textTheme.headlineLarge?.copyWith(
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: state.mediaDetailModel.mediaDetail?.releaseDate
                                                .formatDateInMDYFormat,
                                            style: context.textTheme.titleMedium,
                                          ),
                                          TextSpan(
                                            text: " . ",
                                            style: context.textTheme.headlineLarge,
                                          ),
                                          TextSpan(
                                            text: state.mediaDetailModel.genres(),
                                            style: context.textTheme.titleMedium,
                                          ),
                                          TextSpan(
                                            text: " . ",
                                            style: context.textTheme.headlineLarge,
                                          ),
                                          TextSpan(
                                            text: state.mediaDetailModel.mediaDetail?.runtime
                                                .formatTimeInHM,
                                            style: context.textTheme.titleMedium,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      clipBehavior: Clip.none,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          TmdbUserScore(
                                            average:
                                                state.mediaDetailModel.mediaDetail?.voteAverage ??
                                                    0.0,
                                            voteCount:
                                                state.mediaDetailModel.mediaDetail?.voteCount,
                                            circleSize: 60,
                                            numberStyle: context.textTheme.titleLarge,
                                            style: context.textTheme.titleMedium,
                                          ),
                                          const SizedBox(width: 16),
                                          TmdbIcon(
                                            iconSize: 20,
                                            icons: (Icons.favorite, Icons.favorite_outline_sharp),
                                            isSelected: state
                                                    .mediaDetailModel.mediaAccountState?.favorite ??
                                                false,
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
                                          const SizedBox(width: 30),
                                          TmdbIcon(
                                            iconSize: 20,
                                            icons: (Icons.bookmark, Icons.bookmark_outline_sharp),
                                            isSelected: state.mediaDetailModel.mediaAccountState
                                                    ?.watchlist ??
                                                false,
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
                                          const SizedBox(width: 30),
                                          TooltipRating(
                                            rating: state.mediaDetailModel.mediaAccountState
                                                    ?.getSafeRating() ??
                                                0.0,
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
                                    ),
                                    Visibility(
                                      visible:
                                          state.mediaDetailModel.mediaDetail?.tagline?.isNotEmpty ??
                                              false,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: WrappedText(
                                          state.mediaDetailModel.mediaDetail?.tagline ?? "",
                                          style: context.textTheme.titleMedium?.copyWith(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w100,
                                              color:
                                                  context.colorTheme.onBackground.withOpacity(0.6)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    WrappedText(
                                      context.tr.overview,
                                      style: context.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    WrappedText(
                                      state.mediaDetailModel.mediaDetail?.overview ?? "",
                                      style: context.textTheme.titleSmall,
                                    ),
                                    const SizedBox(height: 16),
                                    Visibility(
                                      visible: state.mediaDetailModel
                                          .getWriterDirectorMapping()
                                          .$1
                                          .isNotEmpty,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: SizedBox(
                                          height: 100,
                                          child: ListView.separated(
                                            separatorBuilder: (ctx, index) =>
                                                const Divider(indent: 80),
                                            itemCount: state.mediaDetailModel
                                                .getWriterDirectorMapping()
                                                .$1
                                                .length,
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (ctx, index) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: WrappedText(
                                                      state.mediaDetailModel
                                                          .getWriterDirectorMapping()
                                                          .$1[index],
                                                      style: context.textTheme.bodyLarge?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: WrappedText(
                                                      state.mediaDetailModel
                                                          .getWriterDirectorMapping()
                                                          .$2[index],
                                                      style: context.textTheme.bodyMedium,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  const Spacer()
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: WrappedText(
                                  context.tr.topBilledCast,
                                  style: context.textTheme.headlineLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                  size: 40,
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
                            height: 8,
                          ),
                          TmdbCastList(
                            model: state.mediaDetailModel.mediaCredits?.cast,
                            mediaDetail: state.mediaDetailModel.mediaDetail,
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: WrappedText(
                                  context.tr.reviews,
                                  style: context.textTheme.headlineLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Visibility(
                                visible: state.mediaDetailModel.mediaReviews?.results?.isNotEmpty ??
                                    false,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    size: 40,
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
                            height: 8,
                          ),
                          TmdbReview(
                            result: state.mediaDetailModel.mediaReviews?.getSafeReview(),
                            mediaDetail: state.mediaDetailModel.mediaDetail,
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: WrappedText(
                                  context.tr.media,
                                  style: context.textTheme.headlineLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                  size: 40,
                                ),
                                onPressed: () {
                                  if (positionCubit.state == 0) {
                                    CommonNavigation.redirectToVideosScreen(
                                      context,
                                      mediaId:
                                          state.mediaDetailModel.mediaDetail?.id?.toString() ?? "",
                                      mediaType: RouteParam.movie,
                                    );
                                    return;
                                  }

                                  CommonNavigation.redirectToPosterBackdropScreen(
                                    context,
                                    state.mediaDetailModel.mediaDetail,
                                    state.mediaDetailModel.mediaDetail?.id.toString() ?? "",
                                    RouteParam.movie,
                                    positionCubit.state == 2,
                                    isDetail: false,
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
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
                            height: 8,
                          ),
                          BlocBuilder<PositionCubit, int>(
                            builder: (context, s) {
                              return TmdbMediaView(
                                mediaDetail: state.mediaDetailModel.mediaDetail,
                                pos: s,
                                videos: state.mediaDetailModel.mediaVideos?.results ?? [],
                                images: state.mediaDetailModel.mediaImages,
                                mediaType: RouteParam.movie,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          WrappedText(
                            context.tr.almostIdentical,
                            style: context.textTheme.headlineLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TmdbRecomendations(
                            recommendations: state.mediaDetailModel.similar?.results ?? [],
                            detail: state.mediaDetailModel.mediaDetail,
                            mediaType: RouteParam.movie,
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          WrappedText(
                            context.tr.recommendations,
                            style: context.textTheme.headlineLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TmdbRecomendations(
                            recommendations:
                                state.mediaDetailModel.mediaRecommendations?.results ?? [],
                            detail: state.mediaDetailModel.mediaDetail,
                            mediaType: RouteParam.movie,
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                        ],
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TmdbShare(
                              tmdbShareModel: state.mediaDetailModel.mediaExternalId,
                              mediaType: RouteParam.movie,
                            ),
                            const SizedBox(height: 16),
                            TmdbSideView(
                              mediaDetail: state.mediaDetailModel.mediaDetail,
                              keywords: state.mediaDetailModel.mediaKeywords?.keywords ?? [],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

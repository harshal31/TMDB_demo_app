import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/tooltip_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/movie_detail_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/position_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/movie_detail_use_case.dart';
import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/common_utils/time_conversion.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/widgets/custom_tab_bar.dart';
import 'package:common_widgets/widgets/tmdb_icon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_cast_list.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_media_view.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_recomendations%20.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_review.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_share.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_side_view.dart';

class MovieDetailMobileScreen extends StatelessWidget {
  const MovieDetailMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final positionCubit = context.read<PositionCubit>();

    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (context, state) {
        if (state.movieDetailState is MovieDetailLoading ||
            state.movieDetailState is MovieDetailNone) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.movieDetailState is MovieDetailFailure) {
          return Center(
            child: Text(
              (state.movieDetailState as MovieDetailFailure).errorResponse.errorMessage,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }

        return CustomScrollView(
          scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 500,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Opacity(
                        opacity: 0.3,
                        child: ExtendedImage.network(
                          state.movieDetailModel.getBackdropImage(),
                          cache: true,
                          fit: BoxFit.cover,
                          shape: BoxShape.rectangle,
                          cacheMaxAge: Duration(minutes: 30),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.colorTheme.primaryContainer.withOpacity(0.5),
                              context.colorTheme.primaryContainer.withOpacity(0.2),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ExtendedImage.network(
                                  state.movieDetailModel.getPosterPath(),
                                  width: 150,
                                  height: 225,
                                  fit: BoxFit.cover,
                                  cache: true,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  cacheMaxAge: Duration(minutes: 30),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${state.movieDetailModel.mediaDetail?.originalTitle ?? ""} ",
                                        style: context.textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "(${state.movieDetailModel.getReleaseYear()})",
                                          style: context.textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    state.movieDetailModel.mediaDetail?.releaseDate
                                            .formatDateInMDYFormat ??
                                        "",
                                    style: context.textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    state.movieDetailModel.genres(),
                                    style: context.textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    state.movieDetailModel.mediaDetail?.runtime.formatTimeInHM ??
                                        "",
                                    style: context.textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 2),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TmdbIcon(
                                          iconSize: 20,
                                          icons: (Icons.favorite, Icons.favorite_outline_sharp),
                                          isSelected: false,
                                          selectedColor: Colors.red,
                                          onSelection: (s) {},
                                          hoverMessage: context.tr.markAsFavorite,
                                        ),
                                        const SizedBox(width: 16),
                                        TmdbIcon(
                                          iconSize: 20,
                                          icons: (Icons.bookmark, Icons.bookmark_outline_sharp),
                                          isSelected: false,
                                          selectedColor: Colors.red,
                                          onSelection: (s) {},
                                          hoverMessage: context.tr.addToWatchlist,
                                        ),
                                        const SizedBox(width: 16),
                                        TooltipRating(
                                          rating: 0,
                                          iconSize: 20,
                                          hoverMessage: context.tr.addToWatchlist,
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    state.movieDetailModel.mediaDetail?.tagline ?? "",
                                    style: context.textTheme.titleSmall?.copyWith(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w100,
                                        color: context.colorTheme.onBackground.withOpacity(0.6)),
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(
                                    height: 40,
                                    child: ListView.separated(
                                      separatorBuilder: (ctx, index) => const Divider(indent: 20),
                                      itemCount: state.movieDetailModel
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
                                            Text(
                                              state.movieDetailModel
                                                  .getWriterDirectorMapping()
                                                  .$1[index],
                                              style: context.textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w900,
                                              ),
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              state.movieDetailModel
                                                  .getWriterDirectorMapping()
                                                  .$2[index],
                                              style: context.textTheme.bodySmall,
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                ],
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
            SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.overview,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      state.movieDetailModel.mediaDetail?.overview ?? "",
                      style: context.textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  color: context.colorTheme.onBackground.withOpacity(0.6),
                  thickness: 2.0,
                  height: 1.0,
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 8)),
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
                          child: Text(
                            context.tr.topBilledCast,
                            style:
                                context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.keyboard_double_arrow_right_sharp,
                            size: 40,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TmdbCastList(
                      model: state.movieDetailModel.mediaCredits?.cast,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      color: context.colorTheme.onBackground.withOpacity(0.6),
                      thickness: 2.0,
                      height: 1.0,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.tr.reviews,
                            style:
                                context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        Visibility(
                          visible:
                              state.movieDetailModel.mediaReviews?.results?.isNotEmpty ?? false,
                          child: IconButton(
                            icon: const Icon(
                              Icons.keyboard_double_arrow_right_sharp,
                              size: 40,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TmdbReview(
                      result: state.movieDetailModel.mediaReviews?.results?.firstOrNull,
                      mediaDetail: state.movieDetailModel.mediaDetail,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      color: context.colorTheme.onBackground.withOpacity(0.6),
                      thickness: 2.0,
                      height: 1.0,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.tr.media,
                            style:
                                context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.keyboard_double_arrow_right_sharp,
                            size: 40,
                          ),
                          onPressed: () {},
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
                      height: 8,
                    ),
                    BlocBuilder<PositionCubit, int>(
                      builder: (context, s) {
                        return TmdbMediaView(
                          height: 200,
                          movieId: state.movieDetailModel.mediaDetail?.id.toString() ?? "",
                          pos: s,
                          videos: state.movieDetailModel.mediaVideos?.results ?? [],
                          images: state.movieDetailModel.mediaImages,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      color: context.colorTheme.onBackground.withOpacity(0.6),
                      thickness: 2.0,
                      height: 1.0,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      context.tr.recommendations,
                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TmdbRecomendations(
                      recommendations: state.movieDetailModel.mediaRecommendations?.results ?? [],
                      detail: state.movieDetailModel.mediaDetail,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  color: context.colorTheme.onBackground.withOpacity(0.6),
                  thickness: 2.0,
                  height: 1.0,
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 8)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TmdbShare(tmdbShareModel: state.movieDetailModel.mediaExternalId),
                    const SizedBox(height: 16),
                    TmdbSideView(
                      keywordSpacing: 2.0,
                      mediaDetail: state.movieDetailModel.mediaDetail,
                      keywords: state.movieDetailModel.mediaKeywords?.keywords ?? [],
                    ),
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

import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/common_utils/time_conversion.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/custom_tab_bar.dart';
import 'package:common_widgets/widgets/dominant_color_from_image.dart';
import 'package:common_widgets/widgets/tmdb_icon.dart';
import 'package:common_widgets/widgets/tooltip_rating.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/movie_detail_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/cubits/position_cubit.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/use_cases/movie_detail_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/extended_image_creator.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_cast_list.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_media_view.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_recomendations%20.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_review.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_share.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_side_view.dart';
import 'package:tmdb_app/routes/route_name.dart';

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
            child: CircularProgressIndicator(),
          );
        }

        if (state.movieDetailState is MovieDetailFailure) {
          return Center(
            child: Text(
              (state.movieDetailState as MovieDetailFailure).errorResponse.errorMessage,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

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
                          child: Opacity(
                            opacity: 0.6,
                            child: ExtendedImageCreator(
                              imageUrl: state.mediaDetailModel.getBackdropImage(),
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: MediaQuery.of(context).size.width * 0.7,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                              ),
                              shouldDisplayErrorImage: false,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: DominantColorFromImage(
                            imageProvider: ExtendedNetworkImageProvider(
                              state.mediaDetailModel.getBackdropImage(),
                              cache: true,
                            ),
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
                    imageProvider: ExtendedNetworkImageProvider(
                      state.mediaDetailModel.getBackdropImage(),
                      cache: true,
                    ),
                    dominantChild: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          "${state.mediaDetailModel.mediaDetail?.originalTitle ?? ""} ",
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          state.mediaDetailModel.getReleaseYear(),
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          textAlign: TextAlign.center,
                          state.mediaDetailModel.mediaDetail?.releaseDate.formatDateInMDYFormat ??
                              "",
                          style: context.textTheme.titleSmall,
                        ),
                        Visibility(
                          visible: state.mediaDetailModel.genres().isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              state.mediaDetailModel.genres(),
                              style: context.textTheme.titleSmall,
                            ),
                          ),
                        ),
                        Text(
                          state.mediaDetailModel.mediaDetail?.runtime.formatTimeInHM ?? "",
                          style: context.textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                      state.mediaDetailModel.mediaAccountState?.getSafeRating() ??
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
                        ),
                        Visibility(
                          visible: state.mediaDetailModel.mediaDetail?.tagline?.isNotEmpty ?? false,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
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
                                        Text(
                                          state.mediaDetailModel
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
                                          state.mediaDetailModel
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
                      Text(
                        context.tr.overview,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
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
                child: Divider(
                  color: context.colorTheme.onBackground.withOpacity(0.6),
                  thickness: 2.0,
                  height: 1.0,
                ),
              ),
            ),
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
                                context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.keyboard_double_arrow_right_sharp,
                            size: 30,
                          ),
                          onPressed: () {
                            final detail = state.mediaDetailModel.mediaDetail;
                            final imageUrl = detail?.getBackdropImage() ?? "";
                            final mediaName = detail?.getMediaName(false) ?? "";
                            context.push(
                              Uri(
                                path:
                                    "${RouteName.home}/${RouteName.movie}/${detail?.id ?? ""}/${RouteName.cast}/${mediaName.encodeString()}/${imageUrl.encodeString()}",
                              ).toString(),
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      color: context.colorTheme.onBackground.withOpacity(0.6),
                      thickness: 2.0,
                      height: 1.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
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
                              Icons.keyboard_double_arrow_right_sharp,
                              size: 30,
                            ),
                            onPressed: () {
                              final value = movieDetailCubit.state.mediaDetailModel.mediaDetail;
                              context.push(
                                Uri(
                                  path:
                                      "${RouteName.home}/${RouteName.movie}/${value?.id}/${RouteName.reviews}",
                                ).toString(),
                                extra: value,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TmdbReview(
                      result: state.mediaDetailModel.mediaReviews?.getSafeReview(),
                      mediaDetail: state.mediaDetailModel.mediaDetail,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      color: context.colorTheme.onBackground.withOpacity(0.6),
                      thickness: 2.0,
                      height: 1.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.tr.media,
                            style:
                                context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.keyboard_double_arrow_right_sharp,
                            size: 30,
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
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 200,
                          mediaId: state.mediaDetailModel.mediaDetail?.id.toString() ?? "",
                          pos: s,
                          videos: state.mediaDetailModel.mediaVideos?.results ?? [],
                          images: state.mediaDetailModel.mediaImages,
                          mediaType: ApiKey.movie,
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
                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TmdbRecomendations(
                      recommendations: state.mediaDetailModel.mediaRecommendations?.results ?? [],
                      detail: state.mediaDetailModel.mediaDetail,
                      mediaType: ApiKey.movie,
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
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
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TmdbShare(tmdbShareModel: state.mediaDetailModel.mediaExternalId),
                    const SizedBox(height: 16),
                    TmdbSideView(
                      keywordSpacing: 2.0,
                      mediaDetail: state.mediaDetailModel.mediaDetail,
                      keywords: state.mediaDetailModel.mediaKeywords?.keywords ?? [],
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

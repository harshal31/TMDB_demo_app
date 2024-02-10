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

class MovieDetailWebScreen extends StatelessWidget {
  const MovieDetailWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final positionCubit = context.read<PositionCubit>();
    final movieDetailCubit = context.read<MovieDetailCubit>();

    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (context, state) {
        if (state.movieDetailState is MovieDetailLoading ||
            state.movieDetailState is MovieDetailNone) {
          return const Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.movieDetailState is MovieDetailFailure) {
          return Center(
            child: Text(
              (state.movieDetailState as MovieDetailFailure).errorResponse.errorMessage,
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }

        return CustomScrollView(
          physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
          scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 570,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Opacity(
                          opacity: 0.3,
                          child: ExtendedImageCreator(
                            imageUrl: state.mediaDetailModel.getBackdropImage(),
                            fit: BoxFit.cover,
                            height: double.infinity,
                            shouldDisplayErrorImage: false,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.zero,
                          ),
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
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
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
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                              "${state.mediaDetailModel.mediaDetail?.originalTitle ?? ""} ",
                                          style: context.textTheme.headlineLarge?.copyWith(
                                            fontWeight: FontWeight.w900,
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            TmdbIcon(
                                              iconSize: 20,
                                              icons: (Icons.favorite, Icons.favorite_outline_sharp),
                                              isSelected: state.mediaDetailModel.mediaAccountState
                                                      ?.favorite ??
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
                                    ),
                                    Visibility(
                                      visible:
                                          state.mediaDetailModel.mediaDetail?.tagline?.isNotEmpty ??
                                              false,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Text(
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
                                    Text(
                                      context.tr.overview,
                                      style: context.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      state.mediaDetailModel.mediaDetail?.overview ?? "",
                                      style: context.textTheme.titleSmall,
                                    ),
                                    const SizedBox(height: 16),
                                    Visibility(
                                      visible: state.mediaDetailModel
                                          .getWriterDirectorMapping()
                                          .$1
                                          .isNotEmpty,
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
                                                  child: Text(
                                                    state.mediaDetailModel
                                                        .getWriterDirectorMapping()
                                                        .$1[index],
                                                    style: context.textTheme.bodyLarge?.copyWith(
                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    state.mediaDetailModel
                                                        .getWriterDirectorMapping()
                                                        .$2[index],
                                                    style: context.textTheme.bodyMedium,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const Spacer(),
                                                const Spacer()
                                              ],
                                            );
                                          },
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
                padding: const EdgeInsets.fromLTRB(50, 16, 50, 16),
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
                                child: Text(
                                  context.tr.topBilledCast,
                                  style: context.textTheme.headlineLarge
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.keyboard_double_arrow_right_sharp,
                                  size: 40,
                                ),
                                onPressed: () {
                                  final id = state.mediaDetailModel.mediaDetail?.id ?? "";
                                  context.push(
                                    Uri(
                                      path:
                                          "${RouteName.home}/${RouteName.movie}/$id/${RouteName.cast}",
                                    ).toString(),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
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
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  context.tr.reviews,
                                  style: context.textTheme.headlineLarge
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                              ),
                              Visibility(
                                visible: state.mediaDetailModel.mediaReviews?.results?.isNotEmpty ??
                                    false,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.keyboard_double_arrow_right_sharp,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    final value =
                                        movieDetailCubit.state.mediaDetailModel.mediaDetail;
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
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  context.tr.media,
                                  style: context.textTheme.headlineLarge
                                      ?.copyWith(fontWeight: FontWeight.w800),
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
                            height: 16,
                          ),
                          BlocBuilder<PositionCubit, int>(
                            builder: (context, s) {
                              return TmdbMediaView(
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
                            style: context.textTheme.headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TmdbRecomendations(
                            recommendations:
                                state.mediaDetailModel.mediaRecommendations?.results ?? [],
                            detail: state.mediaDetailModel.mediaDetail,
                            mediaType: ApiKey.movie,
                          ),
                          const SizedBox(
                            height: 16,
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
                            TmdbShare(tmdbShareModel: state.mediaDetailModel.mediaExternalId),
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

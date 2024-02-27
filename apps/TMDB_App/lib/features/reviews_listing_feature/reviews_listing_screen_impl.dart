import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:common_widgets/widgets/dominant_color_from_image.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:common_widgets/widgets/lottie_loader.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/cubits/cast_crew_cubit.dart';
import 'package:tmdb_app/features/cast_crew_listing_feature/presentation/use_case/cast_crew_use_case.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_reviews.dart';
import 'package:tmdb_app/features/reviews_listing_feature/cubit/reviews_listing_cubit.dart';
import 'package:tmdb_app/features/reviews_listing_feature/cubit/reviews_listing_use_case.dart';
import 'package:tmdb_app/features/tmdb_widgets/tmdb_review.dart';

class ReviewsListingScreenImpl extends StatefulWidget {
  final String mediaId;
  final bool isMovies;

  const ReviewsListingScreenImpl({
    super.key,
    required this.mediaId,
    required this.isMovies,
  });

  @override
  State<ReviewsListingScreenImpl> createState() => _ReviewsListingScreenImplState();
}

class _ReviewsListingScreenImplState extends State<ReviewsListingScreenImpl> {
  final PagingController<int, ReviewResults> reviewsController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _listenMoviesPaginationChanges(context.read());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BlocBuilder<CastCrewCubit, CastCrewState>(
            builder: (context, state) {
              return Visibility(
                visible: state.mediaDetail != null,
                child: SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DominantColorFromImage(
                          imageProvider: ExtendedNetworkImageProvider(
                            state.mediaDetail?.getBackdropImage() ?? "",
                            cache: true,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                ExtendedImageCreator(
                                  imageUrl: state.mediaDetail?.getPosterPath(),
                                  width: 58,
                                  height: 87,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: WrappedText(
                                    state.mediaDetail?.getMediaName(widget.isMovies) ?? "",
                                    style: context.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 16)),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: PagedSliverList.separated(
            pagingController: reviewsController,
            separatorBuilder: (ctx, index) => const SizedBox(height: 16),
            builderDelegate: PagedChildBuilderDelegate<ReviewResults>(
              firstPageProgressIndicatorBuilder: (context) => const LinearLoader(),
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: TextButton(
                  onPressed: () => reviewsController.refresh(),
                  child: WrappedText(
                    context.tr.tryAgain,
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ),
              animateTransitions: true,
              itemBuilder: (ctx, item, index) {
                return TmdbReview(
                  key: ValueKey(index),
                  result: item,
                  shouldUseAnimatedReadMe: false,
                );
              },
            ),
          ),
        )
      ],
    );
  }

  void _listenMoviesPaginationChanges(ReviewsListingCubit reviewsListingCubit) {
    reviewsController.addPageRequestListener((pageKey) {
      reviewsListingCubit.fetchMediaReviews(widget.mediaId, widget.isMovies, pageKey);
    });

    reviewsListingCubit.stream.listen((state) {
      if (state.reviewsListingState is ReviewsListingPaginationLoaded) {
        final isLastPage =
            (state.reviewsListingState as ReviewsListingPaginationLoaded).hasReachedMax;
        if (isLastPage) {
          reviewsController.appendLastPage(
            (state.reviewsListingState as ReviewsListingPaginationLoaded).items,
          );
        } else {
          final nextPageKey = reviewsController.nextPageKey! + 1;
          reviewsController.appendPage(
            (state.reviewsListingState as ReviewsListingPaginationLoaded).items,
            nextPageKey,
          );
        }
      } else if (state.reviewsListingState is ReviewsListingPaginationError) {
        reviewsController.error =
            (state.reviewsListingState as ReviewsListingPaginationError).error;
      }
    });
  }
}

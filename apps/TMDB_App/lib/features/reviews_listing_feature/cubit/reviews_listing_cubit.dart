import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/reviews_listing_feature/cubit/reviews_listing_use_case.dart';

class ReviewsListingCubit extends Cubit<ReviewsListingState> {
  final ReviewsListingUseCase reviewsListingUseCase;
  final int _pageSize = 20;

  ReviewsListingCubit(this.reviewsListingUseCase) : super(ReviewsListingState.initial());

  void fetchMediaReviews(String mediaId, bool isMovies, int page) async {
    if (state.reviewsListingState is ReviewsListingPaginationLoaded &&
        (state.reviewsListingState as ReviewsListingPaginationLoaded).hasReachedMax) {
      return;
    }

    if (page == 1) {
      emit(state.copyWith(reviewsListingState: ReviewsListingPaginationLoading()));
    }

    final reviews = await reviewsListingUseCase.fetchYourReviews(isMovies, mediaId, page);
    reviews.fold(
      (l) {
        emit(
          state.copyWith(
            reviewsListingState: ReviewsListingPaginationError(l.errorMessage),
          ),
        );
      },
      (r) {
        final isLastPage = (r.results?.length ?? 0) < _pageSize;

        emit(
          state.copyWith(
            totalResults: r.totalResults ?? 0,
            reviewsListingState: ReviewsListingPaginationLoaded(
              items: r.results ?? [],
              hasReachedMax: isLastPage,
              model: r,
            ),
          ),
        );
      },
    );
  }
}

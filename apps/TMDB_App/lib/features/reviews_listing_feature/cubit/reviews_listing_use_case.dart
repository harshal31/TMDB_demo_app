import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/routes/route_param.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_reviews.dart';
import 'package:tmdb_app/features/reviews_listing_feature/data/reviews_listing_api_service.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class ReviewsListingUseCase {
  final ReviewsListingApiService reviewsListingApiService;

  ReviewsListingUseCase(this.reviewsListingApiService);

  Future<Either<ErrorResponse, MediaReviews>> fetchYourReviews(
    bool isMovies,
    String mediaId,
    int page, {
    String language = ApiKey.defaultLanguage,
  }) async {
    return await apiCall(
      () => reviewsListingApiService.getMediaReviews(
        isMovies ? ApiKey.movie : ApiKey.tv,
        int.parse(mediaId),
        page,
        language,
      ),
    );
  }
}

class ReviewsListingState with EquatableMixin {
  final ReviewsListingPaginationState reviewsListingState;
  final int totalResults;
  final MediaDetail? mediaDetail;

  ReviewsListingState({
    required this.reviewsListingState,
    required this.totalResults,
    this.mediaDetail,
  });

  factory ReviewsListingState.initial() {
    return ReviewsListingState(
      reviewsListingState: ReviewsListingPaginationNone(),
      totalResults: 0,
      mediaDetail: null,
    );
  }

  ReviewsListingState copyWith({
    ReviewsListingPaginationState? reviewsListingState,
    int? totalResults,
    MediaDetail? mediaDetail,
  }) {
    return ReviewsListingState(
      reviewsListingState: reviewsListingState ?? this.reviewsListingState,
      totalResults: totalResults ?? this.totalResults,
      mediaDetail: mediaDetail ?? this.mediaDetail,
    );
  }

  @override
  List<Object?> get props => [
        reviewsListingState,
        totalResults,
        mediaDetail,
      ];
}

sealed class ReviewsListingPaginationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ReviewsListingPaginationNone extends ReviewsListingPaginationState {}

class ReviewsListingPaginationLoading extends ReviewsListingPaginationState {}

class ReviewsListingPaginationLoaded extends ReviewsListingPaginationState {
  final MediaReviews model;
  final List<ReviewResults> items;
  final bool hasReachedMax;

  ReviewsListingPaginationLoaded({
    required this.model,
    required this.items,
    this.hasReachedMax = false,
  });

  bool get shouldDisplayPages => (this.model.totalResults ?? 0) > 20;

  @override
  List<Object?> get props => [model, items, hasReachedMax];
}

class ReviewsListingPaginationError extends ReviewsListingPaginationState {
  final String error;

  ReviewsListingPaginationError(this.error);
}

import 'package:tmdb_app/constants/app_constant.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_account_state.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_credits.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_detail.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_external_id.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_images.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_keywords.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_recommendations.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_reviews.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_translations.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_videos.dart';

class MediaDetailModel {
  final MediaDetail? mediaDetail;
  final MediaAccountState? mediaAccountState;
  final MediaCredits? mediaCredits;
  final MediaExternalId? mediaExternalId;
  final MediaImages? mediaImages;
  final MediaKeywords? mediaKeywords;
  final MediaRecommendations? mediaRecommendations;
  final MediaReviews? mediaReviews;
  final MediaTranslations? mediaTranslations;
  final MediaVideos? mediaVideos;
  final MediaRecommendations? similar;

  MediaDetailModel({
    this.mediaDetail,
    this.mediaAccountState,
    this.mediaCredits,
    this.mediaExternalId,
    this.mediaImages,
    this.mediaKeywords,
    this.mediaRecommendations,
    this.mediaReviews,
    this.mediaTranslations,
    this.mediaVideos,
    this.similar,
  });

  MediaDetailModel copyWith({
    MediaDetail? mediaDetail,
    MediaAccountState? mediaAccountState,
    MediaCredits? mediaCredits,
    MediaExternalId? mediaExternalId,
    MediaImages? mediaImages,
    MediaKeywords? mediaKeywords,
    MediaRecommendations? mediaRecommendations,
    MediaReviews? mediaReviews,
    MediaTranslations? mediaTranslations,
    MediaVideos? mediaVideos,
    MediaRecommendations? similar,
  }) {
    return MediaDetailModel(
      mediaDetail: mediaDetail ?? this.mediaDetail,
      mediaAccountState: mediaAccountState ?? this.mediaAccountState,
      mediaCredits: mediaCredits ?? this.mediaCredits,
      mediaExternalId: mediaExternalId ?? this.mediaExternalId,
      mediaImages: mediaImages ?? this.mediaImages,
      mediaKeywords: mediaKeywords ?? this.mediaKeywords,
      mediaRecommendations: mediaRecommendations ?? this.mediaRecommendations,
      mediaReviews: mediaReviews ?? this.mediaReviews,
      mediaTranslations: mediaTranslations ?? this.mediaTranslations,
      mediaVideos: mediaVideos ?? this.mediaVideos,
      similar: similar ?? this.similar,
    );
  }

  bool shouldReturnFailure() {
    if (mediaDetail == null) {
      return true;
    }

    if (mediaAccountState == null &&
        mediaCredits == null &&
        mediaExternalId == null &&
        mediaImages == null &&
        mediaKeywords == null &&
        mediaRecommendations == null &&
        mediaReviews == null &&
        mediaTranslations == null &&
        mediaVideos == null) {
      return true;
    }

    return false;
  }

  String getBackdropImage() {
    return AppConstant.originalImageBaseUrl + (mediaDetail?.backdropPath ?? "");
  }

  String getPosterPath() {
    return AppConstant.originalImageBaseUrl + (mediaDetail?.posterPath ?? "");
  }

  String getReleaseYear() {
    try {
      final value = mediaDetail?.releaseDate?.split("-").firstOrNull ?? "-";
      return value.isNotEmpty ? "($value)" : value;
    } catch (e) {
      return "-";
    }
  }

  String getTvSeriesYear() {
    try {
      final value = mediaDetail?.firstAirDate?.split("-").firstOrNull ?? "-";
      return value.isNotEmpty ? "($value)" : value;
    } catch (e) {
      return "-";
    }
  }

  bool shouldDisplayMoreArrow(int pos) {
    if (pos == 0) {
      return (mediaDetail?.videos?.results?.length ?? 0) >= 5;
    }

    if (pos == 1) {
      return (mediaDetail?.images?.backdrops?.length ?? 0) >= 10;
    }

    if (pos == 2) {
      return (mediaDetail?.images?.posters?.length ?? 0) >= 10;
    }

    return true;
  }

  String genres() {
    return mediaDetail?.genres?.map((e) => e.name).join(",") ?? "";
  }

  (List<String>, List<String>) getWriterDirectorMapping() {
    final Map<String, String> map = {};
    mediaCredits?.crew
        ?.where((element) => element.job == "Director" || element.job == "Writer")
        .forEach((e) {
      final re = (e.job?.isNotEmpty ?? false) ? "," : "";

      map.update((e.originalName ?? ""), (value) => value + re + (e.job ?? ""),
          ifAbsent: () => (e.job ?? ""));
    });
    return (map.keys.toList(), map.values.toList());
  }

  (List<String>, List<String>) getTvSeriesMapping() {
    final l1 = mediaDetail?.createdBy?.map((e) => e.name ?? "").toList() ?? [];

    return (List.generate(l1.length, (index) => "Creator"), l1);
  }
}

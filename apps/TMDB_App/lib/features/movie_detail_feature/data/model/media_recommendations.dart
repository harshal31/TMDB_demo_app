import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/constants/app_constant.dart';

part 'media_recommendations.g.dart';

@JsonSerializable()
class MediaRecommendations {
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<RecommendationResults>? results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  MediaRecommendations({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MediaRecommendations.fromJson(Map<String, dynamic> json) =>
      _$MediaRecommendationsFromJson(json);

  Map<String, dynamic> toJson() => _$MediaRecommendationsToJson(this);

  MediaRecommendations copyWith({
    int? page,
    List<RecommendationResults>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return MediaRecommendations(
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

@JsonSerializable()
class RecommendationResults {
  @JsonKey(name: 'adult')
  bool? adult;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'original_language')
  String? originalLanguage;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  @JsonKey(name: 'overview')
  String? overview;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'media_type')
  String? mediaType;
  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;
  @JsonKey(name: 'popularity')
  double? popularity;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  @JsonKey(name: 'video')
  bool? video;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;

  RecommendationResults({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  String get posterImage {
    return AppConstant.imageBaseUrl + (posterPath ?? "");
  }

  String get backDropImage {
    return AppConstant.originalImageBaseUrl + (backdropPath ?? "");
  }

  factory RecommendationResults.fromJson(Map<String, dynamic> json) =>
      _$RecommendationResultsFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationResultsToJson(this);

  RecommendationResults copyWith({
    bool? adult,
    String? backdropPath,
    int? id,
    String? title,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? mediaType,
    List<int>? genreIds,
    double? popularity,
    String? releaseDate,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) {
    return RecommendationResults(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      id: id ?? this.id,
      title: title ?? this.title,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      mediaType: mediaType ?? this.mediaType,
      genreIds: genreIds ?? this.genreIds,
      popularity: popularity ?? this.popularity,
      releaseDate: releaseDate ?? this.releaseDate,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }
}

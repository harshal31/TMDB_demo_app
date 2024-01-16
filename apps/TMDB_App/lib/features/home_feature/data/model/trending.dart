import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/constants/api_key.dart';

part 'trending.g.dart';

@JsonSerializable()
class Trending {
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<Results>? results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  Trending({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory Trending.fromJson(Map<String, dynamic> json) => _$TrendingFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingToJson(this);

  Trending copyWith({
    int? page,
    List<Results>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return Trending(
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

@JsonSerializable()
class Results {
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
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'original_name')
  String? originalName;
  @JsonKey(name: 'first_air_date')
  String? firstAirDate;
  @JsonKey(name: 'origin_country')
  List<String>? originCountry;
  @JsonKey(name: "profile_path")
  String? profilePath;

  Results(
      {this.adult,
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
      this.name,
      this.originalName,
      this.firstAirDate,
      this.originCountry,
      this.profilePath});

  factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

  Results copyWith(
      {bool? adult,
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
      String? name,
      String? originalName,
      String? firstAirDate,
      List<String>? originCountry,
      String? profilePath}) {
    return Results(
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
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      originCountry: originCountry ?? this.originCountry,
      profilePath: profilePath ?? this.profilePath,
    );
  }

  String getImagePath() {
    return this.mediaType == ApiKey.mediaTypePerson
        ? (this.profilePath ?? "")
        : (this.posterPath ?? "");
  }
}

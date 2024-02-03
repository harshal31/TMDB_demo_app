import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/constants/app_constant.dart';

part 'search_tv_model.g.dart';

@JsonSerializable()
class SearchTvModel {
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<TvShows>? tvShows;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  SearchTvModel({
    this.page,
    this.tvShows,
    this.totalPages,
    this.totalResults,
  });

  factory SearchTvModel.fromJson(Map<String, dynamic> json) => _$SearchTvModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTvModelToJson(this);

  SearchTvModel copyWith({
    int? page,
    List<TvShows>? tvShows,
    int? totalPages,
    int? totalResults,
  }) {
    return SearchTvModel(
      page: page ?? this.page,
      tvShows: tvShows ?? this.tvShows,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

@JsonSerializable()
class TvShows {
  @JsonKey(name: 'adult')
  bool? adult;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'origin_country')
  List<String>? originCountry;
  @JsonKey(name: 'original_language')
  String? originalLanguage;
  @JsonKey(name: 'original_name')
  String? originalName;
  @JsonKey(name: 'overview')
  String? overview;
  @JsonKey(name: 'popularity')
  double? popularity;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'first_air_date')
  String? firstAirDate;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'vote_average')
  dynamic voteAverage;
  @JsonKey(name: 'vote_count')
  dynamic voteCount;

  TvShows({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.name,
    this.voteAverage,
    this.voteCount,
  });

  factory TvShows.fromJson(Map<String, dynamic> json) => _$TvShowsFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowsToJson(this);

  String get imageUrl => AppConstant.originalImageBaseUrl + (this.posterPath ?? "");

  TvShows copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    String? firstAirDate,
    String? name,
    dynamic voteAverage,
    dynamic voteCount,
  }) {
    return TvShows(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      originCountry: originCountry ?? this.originCountry,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      name: name ?? this.name,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }
}

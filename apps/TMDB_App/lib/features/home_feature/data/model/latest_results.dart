import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/constants/app_constant.dart';

part 'latest_results.g.dart';

@JsonSerializable()
class LatestResults {
  @JsonKey(name: 'dates')
  Dates? dates;
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<LatestData>? latestData;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  LatestResults({
    this.dates,
    this.page,
    this.latestData,
    this.totalPages,
    this.totalResults,
  });

  factory LatestResults.fromJson(Map<String, dynamic> json) => _$LatestResultsFromJson(json);

  Map<String, dynamic> toJson() => _$LatestResultsToJson(this);

  LatestResults copyWith({
    Dates? dates,
    int? page,
    List<LatestData>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return LatestResults(
      dates: dates ?? this.dates,
      page: page ?? this.page,
      latestData: results ?? this.latestData,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

@JsonSerializable()
class Dates {
  @JsonKey(name: 'maximum')
  String? maximum;
  @JsonKey(name: 'minimum')
  String? minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);

  Dates copyWith({
    String? maximum,
    String? minimum,
  }) {
    return Dates(
      maximum: maximum ?? this.maximum,
      minimum: minimum ?? this.minimum,
    );
  }
}

@JsonSerializable()
class LatestData {
  @JsonKey(name: 'adult')
  bool? adult;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'original_language')
  String? originalLanguage;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  @JsonKey(name: 'overview')
  String? overview;
  @JsonKey(name: 'popularity')
  double? popularity;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'video')
  bool? video;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;
  @JsonKey(name: 'origin_country')
  List<String>? originCountry;
  @JsonKey(name: 'original_name')
  String? originalName;
  @JsonKey(name: 'first_air_date')
  String? firstAirDate;
  @JsonKey(name: 'name')
  String? name;

  LatestData({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
    this.originalName,
    this.firstAirDate,
    this.name,
  });

  factory LatestData.fromJson(Map<String, dynamic> json) => _$LatestDataFromJson(json);

  Map<String, dynamic> toJson() => _$LatestDataToJson(this);

  LatestData copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
    List<String>? originCountry,
    String? originalName,
    String? firstAirDate,
    String? name,
  }) {
    return LatestData(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      originCountry: originCountry ?? this.originCountry,
      originalName: originalName ?? this.originalName,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      name: name ?? this.name,
    );
  }

  String getImagePath() {
    return AppConstant.imageBaseUrl + (this.posterPath ?? this.backdropPath ?? "");
  }

  String getOriginalImagePath() {
    return AppConstant.originalImageBaseUrl + (this.posterPath ?? "");
  }
}

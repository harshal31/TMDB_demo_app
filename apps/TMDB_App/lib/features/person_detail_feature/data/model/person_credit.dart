import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/app_constant.dart';

part 'person_credit.g.dart';

@JsonSerializable()
class PersonCredit {
  @JsonKey(name: 'cast')
  List<PersonCast>? cast;
  @JsonKey(name: 'crew')
  List<PersonCrew>? crew;
  @JsonKey(name: 'id')
  int? id;

  PersonCredit({
    this.cast,
    this.crew,
    this.id,
  });

  factory PersonCredit.fromJson(Map<String, dynamic> json) => _$PersonCreditFromJson(json);

  Map<String, dynamic> toJson() => _$PersonCreditToJson(this);

  PersonCredit copyWith({
    List<PersonCast>? cast,
    List<PersonCrew>? crew,
    int? id,
  }) {
    return PersonCredit(
      cast: cast ?? this.cast,
      crew: crew ?? this.crew,
      id: id ?? this.id,
    );
  }
}

@JsonSerializable()
class PersonCast {
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
  @JsonKey(name: 'character')
  String? character;
  @JsonKey(name: 'credit_id')
  String? creditId;
  @JsonKey(name: 'order')
  int? order;
  @JsonKey(name: 'media_type')
  String? mediaType;
  @JsonKey(name: 'origin_country')
  List<String>? originCountry;
  @JsonKey(name: 'original_name')
  String? originalName;
  @JsonKey(name: 'first_air_date')
  String? firstAirDate;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'episode_count')
  int? episodeCount;

  PersonCast({
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
    this.character,
    this.creditId,
    this.order,
    this.mediaType,
    this.originCountry,
    this.originalName,
    this.firstAirDate,
    this.name,
    this.episodeCount,
  });

  factory PersonCast.fromJson(Map<String, dynamic> json) => _$PersonCastFromJson(json);

  Map<String, dynamic> toJson() => _$PersonCastToJson(this);

  PersonCast copyWith({
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
    String? character,
    String? creditId,
    int? order,
    String? mediaType,
    List<String>? originCountry,
    String? originalName,
    String? firstAirDate,
    String? name,
    int? episodeCount,
  }) {
    return PersonCast(
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
      character: character ?? this.character,
      creditId: creditId ?? this.creditId,
      order: order ?? this.order,
      mediaType: mediaType ?? this.mediaType,
      originCountry: originCountry ?? this.originCountry,
      originalName: originalName ?? this.originalName,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      name: name ?? this.name,
      episodeCount: episodeCount ?? this.episodeCount,
    );
  }

  String get imagePosterPath {
    return AppConstant.imageBaseUrl + (this.posterPath ?? "");
  }

  String get imageBackdropPath {
    return AppConstant.originalImageBaseUrl + (this.backdropPath ?? "");
  }
}

@JsonSerializable()
class PersonCrew {
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
  @JsonKey(name: 'credit_id')
  String? creditId;
  @JsonKey(name: 'department')
  String? department;
  @JsonKey(name: 'job')
  String? job;
  @JsonKey(name: 'media_type')
  String? mediaType;
  @JsonKey(name: 'origin_country')
  List<String>? originCountry;
  @JsonKey(name: 'original_name')
  String? originalName;
  @JsonKey(name: 'first_air_date')
  String? firstAirDate;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'episode_count')
  int? episodeCount;

  PersonCrew({
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
    this.creditId,
    this.department,
    this.job,
    this.mediaType,
    this.originCountry,
    this.originalName,
    this.firstAirDate,
    this.name,
    this.episodeCount,
  });

  String getActualName() {
    String value = this.mediaType == ApiKey.movie
        ? (this.title ?? this.originalTitle ?? "")
        : (this.name ?? this.originalName ?? "");

    return value;
  }

  String getActualDate() {
    String value =
        this.mediaType == ApiKey.movie ? (this.releaseDate ?? "") : (this.firstAirDate ?? "");
    return value;
  }

  factory PersonCrew.fromJson(Map<String, dynamic> json) => _$PersonCrewFromJson(json);

  Map<String, dynamic> toJson() => _$PersonCrewToJson(this);

  PersonCrew copyWith({
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
    String? creditId,
    String? department,
    String? job,
    String? mediaType,
    List<String>? originCountry,
    String? originalName,
    String? firstAirDate,
    String? name,
    int? episodeCount,
  }) {
    return PersonCrew(
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
      creditId: creditId ?? this.creditId,
      department: department ?? this.department,
      job: job ?? this.job,
      mediaType: mediaType ?? this.mediaType,
      originCountry: originCountry ?? this.originCountry,
      originalName: originalName ?? this.originalName,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      name: name ?? this.name,
      episodeCount: episodeCount ?? this.episodeCount,
    );
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/constants/app_constant.dart';

part 'search_person_model.g.dart';

@JsonSerializable()
class SearchPersonModel {
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<Persons>? persons;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  SearchPersonModel({
    this.page,
    this.persons,
    this.totalPages,
    this.totalResults,
  });

  factory SearchPersonModel.fromJson(Map<String, dynamic> json) =>
      _$SearchPersonModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPersonModelToJson(this);

  SearchPersonModel copyWith({
    int? page,
    List<Persons>? persons,
    int? totalPages,
    int? totalResults,
  }) {
    return SearchPersonModel(
      page: page ?? this.page,
      persons: persons ?? this.persons,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

@JsonSerializable()
class Persons {
  @JsonKey(name: 'adult')
  bool? adult;
  @JsonKey(name: 'gender')
  int? gender;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'known_for_department')
  String? knownForDepartment;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'original_name')
  String? originalName;
  @JsonKey(name: 'popularity')
  double? popularity;
  @JsonKey(name: 'profile_path')
  String? profilePath;
  @JsonKey(name: 'known_for')
  List<KnownFor>? knownFor;

  Persons({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.knownFor,
  });

  String get imageUrl => AppConstant.originalImageBaseUrl + (this.profilePath ?? "");

  String get knownForWork {
    final list = knownFor
        ?.map((e) => (e.title ?? e.originalTitle ?? ""))
        .filter((e) => e.isNotEmpty)
        .take(4);
    return ((list?.isNotEmpty ?? false) ? list?.join(", ") : "") ?? "";
  }

  factory Persons.fromJson(Map<String, dynamic> json) => _$PersonsFromJson(json);

  Map<String, dynamic> toJson() => _$PersonsToJson(this);

  Persons copyWith({
    bool? adult,
    int? gender,
    int? id,
    String? knownForDepartment,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
    List<KnownFor>? knownFor,
  }) {
    return Persons(
      adult: adult ?? this.adult,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      popularity: popularity ?? this.popularity,
      profilePath: profilePath ?? this.profilePath,
      knownFor: knownFor ?? this.knownFor,
    );
  }
}

@JsonSerializable()
class KnownFor {
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

  KnownFor({
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

  factory KnownFor.fromJson(Map<String, dynamic> json) => _$KnownForFromJson(json);

  Map<String, dynamic> toJson() => _$KnownForToJson(this);

  KnownFor copyWith({
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
    return KnownFor(
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

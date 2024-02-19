import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/constants/app_constant.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_account_state.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_credits.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_external_id.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_images.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_keywords.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_recommendations.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_reviews.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_translations.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_videos.dart';

part 'media_detail.g.dart';

@JsonSerializable()
class MediaDetail {
  @JsonKey(name: 'adult')
  bool? adult;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'belongs_to_collection')
  BelongsToCollection? belongsToCollection;
  @JsonKey(name: 'budget')
  int? budget;
  @JsonKey(name: 'genres')
  List<Genres>? genres;
  @JsonKey(name: 'homepage')
  String? homepage;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'imdb_id')
  String? imdbId;
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
  @JsonKey(name: 'production_companies')
  List<ProductionCompanies>? productionCompanies;
  @JsonKey(name: 'production_countries')
  List<ProductionCountries>? productionCountries;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  @JsonKey(name: 'revenue')
  int? revenue;
  @JsonKey(name: 'runtime')
  int? runtime;
  @JsonKey(name: 'spoken_languages')
  List<SpokenLanguages>? spokenLanguages;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'tagline')
  String? tagline;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'video')
  bool? video;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;
  @JsonKey(name: 'created_by')
  List<CreatedBy>? createdBy;
  @JsonKey(name: 'episode_run_time')
  List<dynamic>? episodeRunTime;
  @JsonKey(name: 'first_air_date')
  String? firstAirDate;
  @JsonKey(name: 'in_production')
  bool? inProduction;
  @JsonKey(name: 'languages')
  List<String>? languages;
  @JsonKey(name: 'last_air_date')
  String? lastAirDate;
  @JsonKey(name: 'last_episode_to_air')
  LastEpisodeToAir? lastEpisodeToAir;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'next_episode_to_air')
  dynamic nextEpisodeToAir;
  @JsonKey(name: 'networks')
  List<Network>? networks;
  @JsonKey(name: 'number_of_episodes')
  int? numberOfEpisodes;
  @JsonKey(name: 'number_of_seasons')
  int? numberOfSeasons;
  @JsonKey(name: 'origin_country')
  List<String>? originCountry;
  @JsonKey(name: 'original_name')
  String? originalName;
  @JsonKey(name: 'seasons')
  List<Season>? seasons;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'account_states')
  MediaAccountState? accountStates;
  @JsonKey(name: 'credits')
  MediaCredits? credits;
  @JsonKey(name: 'external_ids')
  MediaExternalId? externalIds;
  @JsonKey(name: 'images')
  MediaImages? images;
  @JsonKey(name: 'keywords')
  MediaKeywords? keywords;
  @JsonKey(name: 'recommendations')
  MediaRecommendations? recommendations;
  @JsonKey(name: 'reviews')
  MediaReviews? reviews;
  @JsonKey(name: 'translations')
  MediaTranslations? translations;
  @JsonKey(name: 'videos')
  MediaVideos? videos;

  MediaDetail({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalName,
    this.seasons,
    this.type,
    this.accountStates,
    this.credits,
    this.externalIds,
    this.images,
    this.keywords,
    this.recommendations,
    this.reviews,
    this.translations,
    this.videos,
  });

  String getMediaName(bool isMovies) {
    String value = isMovies
        ? (this.title ?? this.originalTitle ?? "")
        : (this.name ?? this.originalName ?? "");
    String year = isMovies ? (this.getReleaseYear() ?? "") : (this.getTvSeriesYear() ?? "");

    String result = "";
    if (value.isNotEmpty) {
      result = "$value ";
    }

    if (year.isNotEmpty) {
      result += year;
    }

    return result;
  }

  String getActualName(bool isMovies) {
    String value = isMovies
        ? (this.title ?? this.originalTitle ?? "")
        : (this.name ?? this.originalName ?? "");

    return value;
  }

  String getBackdropImage() {
    return AppConstant.originalImageBaseUrl + (backdropPath ?? "");
  }

  String getPosterPath() {
    return AppConstant.originalImageBaseUrl + (posterPath ?? "");
  }

  String getReleaseYear() {
    try {
      final value = releaseDate?.split("-").firstOrNull ?? "-";
      return value.isNotEmpty ? "($value)" : value;
    } catch (e) {
      return "-";
    }
  }

  String getTvSeriesYear() {
    try {
      final value = firstAirDate?.split("-").firstOrNull ?? "-";
      return value.isNotEmpty ? "($value)" : value;
    } catch (e) {
      return "-";
    }
  }

  factory MediaDetail.fromJson(Map<String, dynamic> json) => _$MediaDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MediaDetailToJson(this);

  MediaDetail copyWith({
    bool? adult,
    String? backdropPath,
    BelongsToCollection? belongsToCollection,
    int? budget,
    List<Genres>? genres,
    String? homepage,
    int? id,
    String? imdbId,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    List<ProductionCompanies>? productionCompanies,
    List<ProductionCountries>? productionCountries,
    String? releaseDate,
    int? revenue,
    int? runtime,
    List<SpokenLanguages>? spokenLanguages,
    String? status,
    String? tagline,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
    List<CreatedBy>? createdBy,
    List<dynamic>? episodeRunTime,
    String? firstAirDate,
    bool? inProduction,
    List<String>? languages,
    String? lastAirDate,
    LastEpisodeToAir? lastEpisodeToAir,
    String? name,
    dynamic nextEpisodeToAir,
    List<Network>? networks,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    List<String>? originCountry,
    String? originalName,
    List<Season>? seasons,
    String? type,
    MediaAccountState? accountStates,
    MediaCredits? credits,
    MediaExternalId? externalIds,
    MediaImages? images,
    MediaKeywords? keywords,
    MediaRecommendations? recommendations,
    MediaReviews? reviews,
    MediaTranslations? translations,
    MediaVideos? videos,
  }) {
    return MediaDetail(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      belongsToCollection: belongsToCollection ?? this.belongsToCollection,
      budget: budget ?? this.budget,
      genres: genres ?? this.genres,
      homepage: homepage ?? this.homepage,
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      productionCompanies: productionCompanies ?? this.productionCompanies,
      productionCountries: productionCountries ?? this.productionCountries,
      releaseDate: releaseDate ?? this.releaseDate,
      revenue: revenue ?? this.revenue,
      runtime: runtime ?? this.runtime,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      createdBy: createdBy ?? this.createdBy,
      episodeRunTime: episodeRunTime ?? this.episodeRunTime,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      inProduction: inProduction ?? this.inProduction,
      languages: languages ?? this.languages,
      lastAirDate: lastAirDate ?? this.lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir ?? this.lastEpisodeToAir,
      name: name ?? this.name,
      nextEpisodeToAir: nextEpisodeToAir ?? this.nextEpisodeToAir,
      networks: networks ?? this.networks,
      numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
      originCountry: originCountry ?? this.originCountry,
      originalName: originalName ?? this.originalName,
      seasons: seasons ?? this.seasons,
      type: type ?? this.type,
      accountStates: accountStates ?? this.accountStates,
      credits: credits ?? this.credits,
      externalIds: externalIds ?? this.externalIds,
      images: images ?? this.images,
      keywords: keywords ?? this.keywords,
      recommendations: recommendations ?? this.recommendations,
      reviews: reviews ?? this.reviews,
      translations: translations ?? this.translations,
      videos: videos ?? this.videos,
    );
  }
}

@JsonSerializable()
class BelongsToCollection {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);

  BelongsToCollection copyWith({
    int? id,
    String? name,
    String? posterPath,
    String? backdropPath,
  }) {
    return BelongsToCollection(
      id: id ?? this.id,
      name: name ?? this.name,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
    );
  }
}

@JsonSerializable()
class Genres {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  Genres({
    this.id,
    this.name,
  });

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  Map<String, dynamic> toJson() => _$GenresToJson(this);

  Genres copyWith({
    int? id,
    String? name,
  }) {
    return Genres(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

@JsonSerializable()
class ProductionCompanies {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'logo_path')
  String? logoPath;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'origin_country')
  String? originCountry;

  ProductionCompanies({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompaniesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this);

  ProductionCompanies copyWith({
    int? id,
    String? logoPath,
    String? name,
    String? originCountry,
  }) {
    return ProductionCompanies(
      id: id ?? this.id,
      logoPath: logoPath ?? this.logoPath,
      name: name ?? this.name,
      originCountry: originCountry ?? this.originCountry,
    );
  }
}

@JsonSerializable()
class ProductionCountries {
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;
  @JsonKey(name: 'name')
  String? name;

  ProductionCountries({
    this.iso31661,
    this.name,
  });

  factory ProductionCountries.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountriesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);

  ProductionCountries copyWith({
    String? iso31661,
    String? name,
  }) {
    return ProductionCountries(
      iso31661: iso31661 ?? this.iso31661,
      name: name ?? this.name,
    );
  }
}

@JsonSerializable()
class SpokenLanguages {
  @JsonKey(name: 'english_name')
  String? englishName;
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  @JsonKey(name: 'name')
  String? name;

  SpokenLanguages({
    this.englishName,
    this.iso6391,
    this.name,
  });

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) => _$SpokenLanguagesFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguagesToJson(this);

  SpokenLanguages copyWith({
    String? englishName,
    String? iso6391,
    String? name,
  }) {
    return SpokenLanguages(
      englishName: englishName ?? this.englishName,
      iso6391: iso6391 ?? this.iso6391,
      name: name ?? this.name,
    );
  }
}

@JsonSerializable()
class CreatedBy {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'credit_id')
  String? creditId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'gender')
  int? gender;
  @JsonKey(name: 'profile_path')
  String? profilePath;

  CreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);
}

@JsonSerializable()
class LastEpisodeToAir {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'overview')
  String? overview;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;
  @JsonKey(name: 'air_date')
  String? airDate;
  @JsonKey(name: 'episode_number')
  int? episodeNumber;
  @JsonKey(name: 'episode_type')
  String? episodeType;
  @JsonKey(name: 'production_code')
  String? productionCode;
  @JsonKey(name: 'runtime')
  int? runtime;
  @JsonKey(name: 'season_number')
  int? seasonNumber;
  @JsonKey(name: 'show_id')
  int? showId;
  @JsonKey(name: 'still_path')
  String? stillPath;

  LastEpisodeToAir({
    this.id,
    this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) => _$LastEpisodeToAirFromJson(json);

  Map<String, dynamic> toJson() => _$LastEpisodeToAirToJson(this);
}

@JsonSerializable()
class Network {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'logo_path')
  String? logoPath;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'origin_country')
  String? originCountry;

  Network({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkToJson(this);

  String getNetworkImage() => AppConstant.imageBaseUrl + (this.logoPath ?? "");
}

@JsonSerializable()
class Season {
  @JsonKey(name: 'air_date')
  String? airDate;
  @JsonKey(name: 'episode_count')
  int? episodeCount;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'overview')
  String? overview;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'season_number')
  int? seasonNumber;
  @JsonKey(name: 'vote_average')
  double? voteAverage;

  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonToJson(this);

  String getSeasonImage() => AppConstant.imageBaseUrl + (this.posterPath ?? "");

  String getAirDate() => this.airDate?.split("-").firstOrNull ?? "0";
}

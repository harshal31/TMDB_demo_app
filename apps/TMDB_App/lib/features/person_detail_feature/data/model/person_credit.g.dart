// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_credit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonCredit _$PersonCreditFromJson(Map<String, dynamic> json) => PersonCredit(
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => PersonCast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => PersonCrew.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$PersonCreditToJson(PersonCredit instance) =>
    <String, dynamic>{
      'cast': instance.cast,
      'crew': instance.crew,
      'id': instance.id,
    };

PersonCast _$PersonCastFromJson(Map<String, dynamic> json) => PersonCast(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      character: json['character'] as String?,
      creditId: json['credit_id'] as String?,
      order: json['order'] as int?,
      mediaType: json['media_type'] as String?,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      originalName: json['original_name'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      name: json['name'] as String?,
      episodeCount: json['episode_count'] as int?,
    );

Map<String, dynamic> _$PersonCastToJson(PersonCast instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
      'media_type': instance.mediaType,
      'origin_country': instance.originCountry,
      'original_name': instance.originalName,
      'first_air_date': instance.firstAirDate,
      'name': instance.name,
      'episode_count': instance.episodeCount,
    };

PersonCrew _$PersonCrewFromJson(Map<String, dynamic> json) => PersonCrew(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      creditId: json['credit_id'] as String?,
      department: json['department'] as String?,
      job: json['job'] as String?,
      mediaType: json['media_type'] as String?,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      originalName: json['original_name'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      name: json['name'] as String?,
      episodeCount: json['episode_count'] as int?,
    );

Map<String, dynamic> _$PersonCrewToJson(PersonCrew instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'credit_id': instance.creditId,
      'department': instance.department,
      'job': instance.job,
      'media_type': instance.mediaType,
      'origin_country': instance.originCountry,
      'original_name': instance.originalName,
      'first_air_date': instance.firstAirDate,
      'name': instance.name,
      'episode_count': instance.episodeCount,
    };

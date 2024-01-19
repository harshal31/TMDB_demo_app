// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_translations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaTranslations _$MediaTranslationsFromJson(Map<String, dynamic> json) =>
    MediaTranslations(
      id: json['id'] as int?,
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => Translations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MediaTranslationsToJson(MediaTranslations instance) =>
    <String, dynamic>{
      'id': instance.id,
      'translations': instance.translations,
    };

Translations _$TranslationsFromJson(Map<String, dynamic> json) => Translations(
      iso31661: json['iso_3166_1'] as String?,
      iso6391: json['iso_639_1'] as String?,
      name: json['name'] as String?,
      englishName: json['english_name'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TranslationsToJson(Translations instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso31661,
      'iso_639_1': instance.iso6391,
      'name': instance.name,
      'english_name': instance.englishName,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      homepage: json['homepage'] as String?,
      overview: json['overview'] as String?,
      runtime: json['runtime'] as int?,
      tagline: json['tagline'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'homepage': instance.homepage,
      'overview': instance.overview,
      'runtime': instance.runtime,
      'tagline': instance.tagline,
      'title': instance.title,
    };

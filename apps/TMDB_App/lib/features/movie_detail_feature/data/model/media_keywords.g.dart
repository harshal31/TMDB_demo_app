// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_keywords.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaKeywords _$MediaKeywordsFromJson(Map<String, dynamic> json) =>
    MediaKeywords(
      id: json['id'] as int?,
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => Keywords.fromJson(e as Map<String, dynamic>))
          .toList(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Keywords.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MediaKeywordsToJson(MediaKeywords instance) =>
    <String, dynamic>{
      'id': instance.id,
      'keywords': instance.keywords,
      'results': instance.results,
    };

Keywords _$KeywordsFromJson(Map<String, dynamic> json) => Keywords(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$KeywordsToJson(Keywords instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

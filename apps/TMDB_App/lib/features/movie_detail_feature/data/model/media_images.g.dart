// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaImages _$MediaImagesFromJson(Map<String, dynamic> json) => MediaImages(
      backdrops: (json['backdrops'] as List<dynamic>?)
          ?.map((e) => Backdrops.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
      logos: (json['logos'] as List<dynamic>?)
          ?.map((e) => Logos.fromJson(e as Map<String, dynamic>))
          .toList(),
      posters: (json['posters'] as List<dynamic>?)
          ?.map((e) => Posters.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MediaImagesToJson(MediaImages instance) =>
    <String, dynamic>{
      'backdrops': instance.backdrops,
      'id': instance.id,
      'logos': instance.logos,
      'posters': instance.posters,
    };

Backdrops _$BackdropsFromJson(Map<String, dynamic> json) => Backdrops(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
      height: json['height'] as int?,
      iso6391: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      width: json['width'] as int?,
    );

Map<String, dynamic> _$BackdropsToJson(Backdrops instance) => <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'height': instance.height,
      'iso_639_1': instance.iso6391,
      'file_path': instance.filePath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'width': instance.width,
    };

Logos _$LogosFromJson(Map<String, dynamic> json) => Logos(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
      height: json['height'] as int?,
      iso6391: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      width: json['width'] as int?,
    );

Map<String, dynamic> _$LogosToJson(Logos instance) => <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'height': instance.height,
      'iso_639_1': instance.iso6391,
      'file_path': instance.filePath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'width': instance.width,
    };

Posters _$PostersFromJson(Map<String, dynamic> json) => Posters(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
      height: json['height'] as int?,
      iso6391: json['iso_639_1'] as String?,
      filePath: json['file_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      width: json['width'] as int?,
    );

Map<String, dynamic> _$PostersToJson(Posters instance) => <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'height': instance.height,
      'iso_639_1': instance.iso6391,
      'file_path': instance.filePath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'width': instance.width,
    };

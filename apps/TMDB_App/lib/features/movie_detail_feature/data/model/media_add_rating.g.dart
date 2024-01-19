// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_add_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaAddRating _$MediaAddRatingFromJson(Map<String, dynamic> json) =>
    MediaAddRating(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      statusMessage: json['status_message'] as String?,
    );

Map<String, dynamic> _$MediaAddRatingToJson(MediaAddRating instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'status_message': instance.statusMessage,
    };

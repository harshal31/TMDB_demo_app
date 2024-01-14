// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_request_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewRequestToken _$NewRequestTokenFromJson(Map<String, dynamic> json) =>
    NewRequestToken(
      success: json['success'] as bool?,
      expiresAt: json['expires_at'] as String?,
      requestToken: json['request_token'] as String?,
    );

Map<String, dynamic> _$NewRequestTokenToJson(NewRequestToken instance) =>
    <String, dynamic>{
      'success': instance.success,
      'expires_at': instance.expiresAt,
      'request_token': instance.requestToken,
    };

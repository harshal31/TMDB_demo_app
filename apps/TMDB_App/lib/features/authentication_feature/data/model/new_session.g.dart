// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewSession _$NewSessionFromJson(Map<String, dynamic> json) => NewSession(
      success: json['success'] as bool?,
      sessionId: json['session_id'] as String?,
    );

Map<String, dynamic> _$NewSessionToJson(NewSession instance) =>
    <String, dynamic>{
      'success': instance.success,
      'session_id': instance.sessionId,
    };

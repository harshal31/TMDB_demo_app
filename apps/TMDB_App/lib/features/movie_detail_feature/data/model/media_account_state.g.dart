// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_account_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaAccountState _$MediaAccountStateFromJson(Map<String, dynamic> json) =>
    MediaAccountState(
      id: json['id'] as int?,
      favorite: json['favorite'] as bool?,
      rated: json['rated'] == null
          ? null
          : Rated.fromJson(json['rated'] as Map<String, dynamic>),
      watchlist: json['watchlist'] as bool?,
    );

Map<String, dynamic> _$MediaAccountStateToJson(MediaAccountState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'favorite': instance.favorite,
      'rated': instance.rated,
      'watchlist': instance.watchlist,
    };

Rated _$RatedFromJson(Map<String, dynamic> json) => Rated(
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RatedToJson(Rated instance) => <String, dynamic>{
      'value': instance.value,
    };

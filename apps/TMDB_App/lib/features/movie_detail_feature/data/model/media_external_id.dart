import 'package:json_annotation/json_annotation.dart';

part 'media_external_id.g.dart';

@JsonSerializable()
class MediaExternalId {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'imdb_id')
  String? imdbId;
  @JsonKey(name: 'wikidata_id')
  String? wikidataId;
  @JsonKey(name: 'facebook_id')
  String? facebookId;
  @JsonKey(name: 'instagram_id')
  String? instagramId;
  @JsonKey(name: 'twitter_id')
  String? twitterId;

  MediaExternalId({
    this.id,
    this.imdbId,
    this.wikidataId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
  });

  factory MediaExternalId.fromJson(Map<String, dynamic> json) => _$MediaExternalIdFromJson(json);

  Map<String, dynamic> toJson() => _$MediaExternalIdToJson(this);

  MediaExternalId copyWith({
    int? id,
    String? imdbId,
    String? wikidataId,
    String? facebookId,
    String? instagramId,
    String? twitterId,
  }) {
    return MediaExternalId(
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      wikidataId: wikidataId ?? this.wikidataId,
      facebookId: facebookId ?? this.facebookId,
      instagramId: instagramId ?? this.instagramId,
      twitterId: twitterId ?? this.twitterId,
    );
  }

  bool get isFidAvailable {
    return facebookId?.isNotEmpty ?? false;
  }

  bool get isInstaIdAvailable {
    return instagramId?.isNotEmpty ?? false;
  }

  bool get isTwitIdAvailable {
    return twitterId?.isNotEmpty ?? false;
  }

  bool get isWikiIdAvailable {
    return wikidataId?.isNotEmpty ?? false;
  }

  bool get isImdbIdAvailable {
    return imdbId?.isNotEmpty ?? false;
  }
}

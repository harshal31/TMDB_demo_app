import 'package:json_annotation/json_annotation.dart';
part 'media_videos.g.dart';

@JsonSerializable()
class MediaVideos {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'results')
  List<Results>? results;

  MediaVideos({
    this.id,
    this.results,
  });

  factory MediaVideos.fromJson(Map<String, dynamic> json) =>
      _$MediaVideosFromJson(json);

  Map<String, dynamic> toJson() => _$MediaVideosToJson(this);

  MediaVideos copyWith({
    int? id,
    List<Results>? results,
  }) {
    return MediaVideos(
      id: id ?? this.id,
      results: results ?? this.results,
    );
  }
}

@JsonSerializable()
class Results {
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'key')
  String? key;
  @JsonKey(name: 'site')
  String? site;
  @JsonKey(name: 'size')
  int? size;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'official')
  bool? official;
  @JsonKey(name: 'published_at')
  String? publishedAt;
  @JsonKey(name: 'id')
  String? id;

  Results({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);

  Results copyWith({
    String? iso6391,
    String? iso31661,
    String? name,
    String? key,
    String? site,
    int? size,
    String? type,
    bool? official,
    String? publishedAt,
    String? id,
  }) {
    return Results(
      iso6391: iso6391 ?? this.iso6391,
      iso31661: iso31661 ?? this.iso31661,
      name: name ?? this.name,
      key: key ?? this.key,
      site: site ?? this.site,
      size: size ?? this.size,
      type: type ?? this.type,
      official: official ?? this.official,
      publishedAt: publishedAt ?? this.publishedAt,
      id: id ?? this.id,
    );
  }
}

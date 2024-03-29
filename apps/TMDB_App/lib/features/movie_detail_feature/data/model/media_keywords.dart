import 'package:json_annotation/json_annotation.dart';

part 'media_keywords.g.dart';

@JsonSerializable()
class MediaKeywords {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'keywords')
  List<Keywords>? keywords;
  @JsonKey(name: 'results')
  List<Keywords>? results;

  MediaKeywords({this.id, this.keywords, this.results});

  factory MediaKeywords.fromJson(Map<String, dynamic> json) => _$MediaKeywordsFromJson(json);

  Map<String, dynamic> toJson() => _$MediaKeywordsToJson(this);

  MediaKeywords copyWith({
    int? id,
    List<Keywords>? keywords,
    List<Keywords>? results,
  }) {
    return MediaKeywords(
      id: id ?? this.id,
      keywords: keywords ?? this.keywords,
      results: results ?? this.results,
    );
  }
}

@JsonSerializable()
class Keywords {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  Keywords({
    this.id,
    this.name,
  });

  factory Keywords.fromJson(Map<String, dynamic> json) => _$KeywordsFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordsToJson(this);

  Keywords copyWith({
    int? id,
    String? name,
  }) {
    return Keywords(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

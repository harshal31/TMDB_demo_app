import 'package:json_annotation/json_annotation.dart';
part 'media_translations.g.dart';

@JsonSerializable()
class MediaTranslations {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'translations')
  List<Translations>? translations;

  MediaTranslations({
    this.id,
    this.translations,
  });

  factory MediaTranslations.fromJson(Map<String, dynamic> json) =>
      _$MediaTranslationsFromJson(json);

  Map<String, dynamic> toJson() => _$MediaTranslationsToJson(this);

  MediaTranslations copyWith({
    int? id,
    List<Translations>? translations,
  }) {
    return MediaTranslations(
      id: id ?? this.id,
      translations: translations ?? this.translations,
    );
  }
}

@JsonSerializable()
class Translations {
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'english_name')
  String? englishName;
  @JsonKey(name: 'data')
  Data? data;

  Translations({
    this.iso31661,
    this.iso6391,
    this.name,
    this.englishName,
    this.data,
  });

  factory Translations.fromJson(Map<String, dynamic> json) =>
      _$TranslationsFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationsToJson(this);

  Translations copyWith({
    String? iso31661,
    String? iso6391,
    String? name,
    String? englishName,
    Data? data,
  }) {
    return Translations(
      iso31661: iso31661 ?? this.iso31661,
      iso6391: iso6391 ?? this.iso6391,
      name: name ?? this.name,
      englishName: englishName ?? this.englishName,
      data: data ?? this.data,
    );
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'homepage')
  String? homepage;
  @JsonKey(name: 'overview')
  String? overview;
  @JsonKey(name: 'runtime')
  int? runtime;
  @JsonKey(name: 'tagline')
  String? tagline;
  @JsonKey(name: 'title')
  String? title;

  Data({
    this.homepage,
    this.overview,
    this.runtime,
    this.tagline,
    this.title,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  Data copyWith({
    String? homepage,
    String? overview,
    int? runtime,
    String? tagline,
    String? title,
  }) {
    return Data(
      homepage: homepage ?? this.homepage,
      overview: overview ?? this.overview,
      runtime: runtime ?? this.runtime,
      tagline: tagline ?? this.tagline,
      title: title ?? this.title,
    );
  }
}

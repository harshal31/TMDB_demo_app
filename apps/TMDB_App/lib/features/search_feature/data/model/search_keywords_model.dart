import 'package:json_annotation/json_annotation.dart';

part 'search_keywords_model.g.dart';

@JsonSerializable()
class SearchKeywordsModel {
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<SearchKeywords>? searchKeywords;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  SearchKeywordsModel({
    this.page,
    this.searchKeywords,
    this.totalPages,
    this.totalResults,
  });

  factory SearchKeywordsModel.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeywordsModelToJson(this);

  SearchKeywordsModel copyWith({
    int? page,
    List<SearchKeywords>? searchKeywords,
    int? totalPages,
    int? totalResults,
  }) {
    return SearchKeywordsModel(
      page: page ?? this.page,
      searchKeywords: searchKeywords ?? this.searchKeywords,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

@JsonSerializable()
class SearchKeywords {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  SearchKeywords({
    this.id,
    this.name,
  });

  factory SearchKeywords.fromJson(Map<String, dynamic> json) => _$SearchKeywordsFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeywordsToJson(this);

  SearchKeywords copyWith({
    int? id,
    String? name,
  }) {
    return SearchKeywords(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

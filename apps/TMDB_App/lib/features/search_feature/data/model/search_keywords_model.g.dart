// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_keywords_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchKeywordsModel _$SearchKeywordsModelFromJson(Map<String, dynamic> json) =>
    SearchKeywordsModel(
      page: json['page'] as int?,
      searchKeywords: (json['results'] as List<dynamic>?)
          ?.map((e) => SearchKeywords.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );

Map<String, dynamic> _$SearchKeywordsModelToJson(
        SearchKeywordsModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.searchKeywords,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

SearchKeywords _$SearchKeywordsFromJson(Map<String, dynamic> json) =>
    SearchKeywords(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SearchKeywordsToJson(SearchKeywords instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

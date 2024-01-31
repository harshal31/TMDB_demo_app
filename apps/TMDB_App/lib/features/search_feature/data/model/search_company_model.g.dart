// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCompanyModel _$SearchCompanyModelFromJson(Map<String, dynamic> json) =>
    SearchCompanyModel(
      page: json['page'] as int?,
      companies: (json['results'] as List<dynamic>?)
          ?.map((e) => Companies.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );

Map<String, dynamic> _$SearchCompanyModelToJson(SearchCompanyModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.companies,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

Companies _$CompaniesFromJson(Map<String, dynamic> json) => Companies(
      id: json['id'] as int?,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String?,
      originCountry: json['origin_country'] as String?,
    );

Map<String, dynamic> _$CompaniesToJson(Companies instance) => <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logoPath,
      'name': instance.name,
      'origin_country': instance.originCountry,
    };

import 'package:json_annotation/json_annotation.dart';

part 'search_company_model.g.dart';

@JsonSerializable()
class SearchCompanyModel {
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<Companies>? companies;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  SearchCompanyModel({
    this.page,
    this.companies,
    this.totalPages,
    this.totalResults,
  });

  factory SearchCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$SearchCompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCompanyModelToJson(this);

  SearchCompanyModel copyWith({
    int? page,
    List<Companies>? companies,
    int? totalPages,
    int? totalResults,
  }) {
    return SearchCompanyModel(
      page: page ?? this.page,
      companies: companies ?? this.companies,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

@JsonSerializable()
class Companies {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'logo_path')
  String? logoPath;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'origin_country')
  String? originCountry;

  Companies({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory Companies.fromJson(Map<String, dynamic> json) => _$CompaniesFromJson(json);

  Map<String, dynamic> toJson() => _$CompaniesToJson(this);

  Companies copyWith({
    int? id,
    String? logoPath,
    String? name,
    String? originCountry,
  }) {
    return Companies(
      id: id ?? this.id,
      logoPath: logoPath ?? this.logoPath,
      name: name ?? this.name,
      originCountry: originCountry ?? this.originCountry,
    );
  }
}

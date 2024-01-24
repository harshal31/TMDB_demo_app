import 'package:common_widgets/common_utils/date_util.dart';
import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_detail.g.dart';

@JsonSerializable()
class PersonDetail {
  @JsonKey(name: 'adult')
  bool? adult;
  @JsonKey(name: 'also_known_as')
  List<String>? alsoKnownAs;
  @JsonKey(name: 'biography')
  String? biography;
  @JsonKey(name: 'birthday')
  String? birthday;
  @JsonKey(name: 'deathday')
  dynamic deathday;
  @JsonKey(name: 'gender')
  int? gender;
  @JsonKey(name: 'homepage')
  dynamic homepage;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'imdb_id')
  String? imdbId;
  @JsonKey(name: 'known_for_department')
  String? knownForDepartment;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'place_of_birth')
  String? placeOfBirth;
  @JsonKey(name: 'popularity')
  double? popularity;
  @JsonKey(name: 'profile_path')
  String? profilePath;

  PersonDetail({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  factory PersonDetail.fromJson(Map<String, dynamic> json) => _$PersonDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PersonDetailToJson(this);

  PersonDetail copyWith({
    bool? adult,
    List<String>? alsoKnownAs,
    String? biography,
    String? birthday,
    dynamic deathday,
    int? gender,
    dynamic homepage,
    int? id,
    String? imdbId,
    String? knownForDepartment,
    String? name,
    String? placeOfBirth,
    double? popularity,
    String? profilePath,
  }) {
    return PersonDetail(
      adult: adult ?? this.adult,
      alsoKnownAs: alsoKnownAs ?? this.alsoKnownAs,
      biography: biography ?? this.biography,
      birthday: birthday ?? this.birthday,
      deathday: deathday ?? this.deathday,
      gender: gender ?? this.gender,
      homepage: homepage ?? this.homepage,
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      name: name ?? this.name,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      popularity: popularity ?? this.popularity,
      profilePath: profilePath ?? this.profilePath,
    );
  }

  String get genderString {
    if (this.gender == 0) {
      return "Not set / not specified";
    }
    if (this.gender == 1) {
      return "Female";
    }
    if (this.gender == 2) {
      return "Male";
    }
    if (this.gender == 3) {
      return "Non-binary";
    }

    return "";
  }

  String getYearsOld(BuildContext context) {
    return "(${context.tr.yearOld(this.birthday.yearFromDate)})";
  }

  String get alsoKnownAsString {
    return this.alsoKnownAs?.join(",") ?? "";
  }
}

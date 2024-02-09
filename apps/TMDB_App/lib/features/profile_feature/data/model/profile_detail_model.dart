import 'package:json_annotation/json_annotation.dart';

part 'profile_detail_model.g.dart';

@JsonSerializable()
class ProfileDetailModel {
  @JsonKey(name: 'avatar')
  Avatar? avatar;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'include_adult')
  bool? includeAdult;
  @JsonKey(name: 'username')
  String? username;

  ProfileDetailModel({
    this.avatar,
    this.id,
    this.iso6391,
    this.iso31661,
    this.name,
    this.includeAdult,
    this.username,
  });

  factory ProfileDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDetailModelToJson(this);

  ProfileDetailModel copyWith({
    Avatar? avatar,
    int? id,
    String? iso6391,
    String? iso31661,
    String? name,
    bool? includeAdult,
    String? username,
  }) {
    return ProfileDetailModel(
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
      iso6391: iso6391 ?? this.iso6391,
      iso31661: iso31661 ?? this.iso31661,
      name: name ?? this.name,
      includeAdult: includeAdult ?? this.includeAdult,
      username: username ?? this.username,
    );
  }
}

@JsonSerializable()
class Avatar {
  @JsonKey(name: 'gravatar')
  Gravatar? gravatar;
  @JsonKey(name: 'tmdb')
  Tmdb? tmdb;

  Avatar({
    this.gravatar,
    this.tmdb,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarToJson(this);

  Avatar copyWith({
    Gravatar? gravatar,
    Tmdb? tmdb,
  }) {
    return Avatar(
      gravatar: gravatar ?? this.gravatar,
      tmdb: tmdb ?? this.tmdb,
    );
  }
}

@JsonSerializable()
class Gravatar {
  @JsonKey(name: 'hash')
  String? hash;

  Gravatar({
    this.hash,
  });

  factory Gravatar.fromJson(Map<String, dynamic> json) => _$GravatarFromJson(json);

  Map<String, dynamic> toJson() => _$GravatarToJson(this);

  Gravatar copyWith({
    String? hash,
  }) {
    return Gravatar(
      hash: hash ?? this.hash,
    );
  }
}

@JsonSerializable()
class Tmdb {
  @JsonKey(name: 'avatar_path')
  String? avatarPath;

  Tmdb({
    this.avatarPath,
  });

  factory Tmdb.fromJson(Map<String, dynamic> json) => _$TmdbFromJson(json);

  Map<String, dynamic> toJson() => _$TmdbToJson(this);

  Tmdb copyWith({
    String? avatarPath,
  }) {
    return Tmdb(
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/constants/app_constant.dart';

part 'media_images.g.dart';

@JsonSerializable()
class MediaImages {
  @JsonKey(name: 'backdrops')
  List<Backdrops>? backdrops;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'logos')
  List<Logos>? logos;
  @JsonKey(name: 'posters')
  List<Posters>? posters;

  MediaImages({
    this.backdrops,
    this.id,
    this.logos,
    this.posters,
  });

  factory MediaImages.fromJson(Map<String, dynamic> json) => _$MediaImagesFromJson(json);

  Map<String, dynamic> toJson() => _$MediaImagesToJson(this);

  MediaImages copyWith({
    List<Backdrops>? backdrops,
    int? id,
    List<Logos>? logos,
    List<Posters>? posters,
  }) {
    return MediaImages(
      backdrops: backdrops ?? this.backdrops,
      id: id ?? this.id,
      logos: logos ?? this.logos,
      posters: posters ?? this.posters,
    );
  }

  Map<String, List<Backdrops>> groupBackdropsByLanguage() {
    return this.backdrops?.groupListsBy((element) => element.iso6391 ?? "") ?? {};
  }

  Map<String, List<Posters>> groupPostersByLanguage() {
    return this.posters?.groupListsBy((element) => element.iso6391 ?? "") ?? {};
  }
}

@JsonSerializable()
class Backdrops {
  @JsonKey(name: 'aspect_ratio')
  double? aspectRatio;
  @JsonKey(name: 'height')
  int? height;
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  @JsonKey(name: 'file_path')
  String? filePath;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;
  @JsonKey(name: 'width')
  int? width;

  Backdrops({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  String getImage() {
    return AppConstant.originalImageBaseUrl + (this.filePath ?? "");
  }

  factory Backdrops.fromJson(Map<String, dynamic> json) => _$BackdropsFromJson(json);

  Map<String, dynamic> toJson() => _$BackdropsToJson(this);

  Backdrops copyWith({
    double? aspectRatio,
    int? height,
    String? iso6391,
    String? filePath,
    double? voteAverage,
    int? voteCount,
    int? width,
  }) {
    return Backdrops(
      aspectRatio: aspectRatio ?? this.aspectRatio,
      height: height ?? this.height,
      iso6391: iso6391 ?? this.iso6391,
      filePath: filePath ?? this.filePath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      width: width ?? this.width,
    );
  }
}

@JsonSerializable()
class Logos {
  @JsonKey(name: 'aspect_ratio')
  double? aspectRatio;
  @JsonKey(name: 'height')
  int? height;
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  @JsonKey(name: 'file_path')
  String? filePath;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;
  @JsonKey(name: 'width')
  int? width;

  Logos({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory Logos.fromJson(Map<String, dynamic> json) => _$LogosFromJson(json);

  Map<String, dynamic> toJson() => _$LogosToJson(this);

  Logos copyWith({
    double? aspectRatio,
    int? height,
    String? iso6391,
    String? filePath,
    double? voteAverage,
    int? voteCount,
    int? width,
  }) {
    return Logos(
      aspectRatio: aspectRatio ?? this.aspectRatio,
      height: height ?? this.height,
      iso6391: iso6391 ?? this.iso6391,
      filePath: filePath ?? this.filePath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      width: width ?? this.width,
    );
  }
}

@JsonSerializable()
class Posters {
  @JsonKey(name: 'aspect_ratio')
  double? aspectRatio;
  @JsonKey(name: 'height')
  int? height;
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  @JsonKey(name: 'file_path')
  String? filePath;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;
  @JsonKey(name: 'width')
  int? width;

  Posters({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory Posters.fromJson(Map<String, dynamic> json) => _$PostersFromJson(json);

  Map<String, dynamic> toJson() => _$PostersToJson(this);

  Posters copyWith({
    double? aspectRatio,
    int? height,
    String? iso6391,
    String? filePath,
    double? voteAverage,
    int? voteCount,
    int? width,
  }) {
    return Posters(
      aspectRatio: aspectRatio ?? this.aspectRatio,
      height: height ?? this.height,
      iso6391: iso6391 ?? this.iso6391,
      filePath: filePath ?? this.filePath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      width: width ?? this.width,
    );
  }

  String getImage() {
    return AppConstant.imageBaseUrl + (this.filePath ?? "");
  }
}

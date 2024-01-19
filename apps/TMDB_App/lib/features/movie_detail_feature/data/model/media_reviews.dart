import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/constants/app_constant.dart';
part 'media_reviews.g.dart';

@JsonSerializable()
class MediaReviews {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'results')
  List<ReviewResults>? results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  MediaReviews({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MediaReviews.fromJson(Map<String, dynamic> json) =>
      _$MediaReviewsFromJson(json);

  Map<String, dynamic> toJson() => _$MediaReviewsToJson(this);

  MediaReviews copyWith({
    int? id,
    int? page,
    List<ReviewResults>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return MediaReviews(
      id: id ?? this.id,
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

@JsonSerializable()
class ReviewResults {
  @JsonKey(name: 'author')
  String? author;
  @JsonKey(name: 'author_details')
  AuthorDetails? authorDetails;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'url')
  String? url;

  ReviewResults({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  factory ReviewResults.fromJson(Map<String, dynamic> json) =>
      _$ReviewResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewResultsToJson(this);

  ReviewResults copyWith({
    String? author,
    AuthorDetails? authorDetails,
    String? content,
    String? createdAt,
    String? id,
    String? updatedAt,
    String? url,
  }) {
    return ReviewResults(
      author: author ?? this.author,
      authorDetails: authorDetails ?? this.authorDetails,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      url: url ?? this.url,
    );
  }
}

@JsonSerializable()
class AuthorDetails {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'avatar_path')
  String? avatarPath;
  @JsonKey(name: 'rating')
  int? rating;

  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  String getAvatar() {
    return AppConstant.originalImageBaseUrl + (this.avatarPath ?? "");
  }
  factory AuthorDetails.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorDetailsToJson(this);

  AuthorDetails copyWith({
    String? name,
    String? username,
    String? avatarPath,
    int? rating,
  }) {
    return AuthorDetails(
      name: name ?? this.name,
      username: username ?? this.username,
      avatarPath: avatarPath ?? this.avatarPath,
      rating: rating ?? this.rating,
    );
  }
}

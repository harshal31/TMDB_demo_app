import 'package:json_annotation/json_annotation.dart';
part 'media_add_rating.g.dart';

@JsonSerializable()
class MediaAddRating {
  @JsonKey(name: 'success')
  bool? success;
  @JsonKey(name: 'status_code')
  int? statusCode;
  @JsonKey(name: 'status_message')
  String? statusMessage;

  MediaAddRating({
    this.success,
    this.statusCode,
    this.statusMessage,
  });

  factory MediaAddRating.fromJson(Map<String, dynamic> json) =>
      _$MediaAddRatingFromJson(json);

  Map<String, dynamic> toJson() => _$MediaAddRatingToJson(this);

  MediaAddRating copyWith({
    bool? success,
    int? statusCode,
    String? statusMessage,
  }) {
    return MediaAddRating(
      success: success ?? this.success,
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }
}

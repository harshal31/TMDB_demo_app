import "package:json_annotation/json_annotation.dart";

part "new_request_token.g.dart";

@JsonSerializable()
class NewRequestToken {
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "expires_at")
  String? expiresAt;
  @JsonKey(name: "request_token")
  String? requestToken;

  NewRequestToken({
    this.success,
    this.expiresAt,
    this.requestToken,
  });

  factory NewRequestToken.fromJson(Map<String, dynamic> json) =>
      _$NewRequestTokenFromJson(json);

  Map<String, dynamic> toJson() => _$NewRequestTokenToJson(this);

  NewRequestToken copyWith({
    bool? success,
    String? expiresAt,
    String? requestToken,
  }) {
    return NewRequestToken(
      success: success ?? this.success,
      expiresAt: expiresAt ?? this.expiresAt,
      requestToken: requestToken ?? this.requestToken,
    );
  }
}

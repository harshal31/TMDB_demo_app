import "package:json_annotation/json_annotation.dart";
import "package:tmdb_app/features/authentication_feature/data/model/new_request_token.dart";

part "new_session.g.dart";

@JsonSerializable()
class NewSession {
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "session_id")
  String? sessionId;

  NewSession({
    this.success,
    this.sessionId,
  });

  factory NewSession.fromJson(Map<String, dynamic> json) => _$NewSessionFromJson(json);

  Map<String, dynamic> toJson() => _$NewSessionToJson(this);

  NewSession copyWith({
    bool? success,
    String? sessionId,
  }) {
    return NewSession(
      success: success ?? this.success,
      sessionId: sessionId ?? this.sessionId,
    );
  }
}

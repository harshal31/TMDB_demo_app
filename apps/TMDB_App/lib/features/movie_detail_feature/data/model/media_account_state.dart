import 'package:json_annotation/json_annotation.dart';

part 'media_account_state.g.dart';

@JsonSerializable()
class MediaAccountState {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'favorite')
  bool? favorite;
  @JsonKey(name: 'rated')
  Rated? rated;
  @JsonKey(name: 'watchlist')
  bool? watchlist;

  MediaAccountState({
    this.id,
    this.favorite,
    this.rated,
    this.watchlist,
  });

  factory MediaAccountState.fromJson(Map<String, dynamic> json) =>
      _$MediaAccountStateFromJson(json);

  Map<String, dynamic> toJson() => _$MediaAccountStateToJson(this);

  MediaAccountState copyWith({
    int? id,
    bool? favorite,
    Rated? rated,
    bool? watchlist,
  }) {
    return MediaAccountState(
      id: id ?? this.id,
      favorite: favorite ?? this.favorite,
      rated: rated ?? this.rated,
      watchlist: watchlist ?? this.watchlist,
    );
  }
}

@JsonSerializable()
class Rated {
  @JsonKey(name: 'value')
  double? value;

  Rated({
    this.value,
  });

  factory Rated.fromJson(Map<String, dynamic> json) => _$RatedFromJson(json);

  Map<String, dynamic> toJson() => _$RatedToJson(this);

  Rated copyWith({
    double? value,
  }) {
    return Rated(
      value: value ?? this.value,
    );
  }
}

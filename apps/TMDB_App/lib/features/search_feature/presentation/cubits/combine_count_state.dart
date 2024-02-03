import 'package:equatable/equatable.dart';

class CombineCountState with EquatableMixin {
  final int movieCount;
  final int tvShowsCount;
  final int personCount;
  final int keywordsCount;
  final int companyCount;
  final String uniqueKey;

  CombineCountState({
    required this.movieCount,
    required this.tvShowsCount,
    required this.personCount,
    required this.keywordsCount,
    required this.companyCount,
    required this.uniqueKey,
  });

  factory CombineCountState.initial() {
    return CombineCountState(
      movieCount: 0,
      tvShowsCount: 0,
      personCount: 0,
      keywordsCount: 0,
      companyCount: 0,
      uniqueKey: "",
    );
  }

  CombineCountState copyWith(
      {int? movieCount,
      int? tvShowsCount,
      int? personCount,
      int? keywordsCount,
      int? companyCount,
      String? uniqueKey}) {
    return CombineCountState(
      movieCount: movieCount ?? this.movieCount,
      tvShowsCount: tvShowsCount ?? this.tvShowsCount,
      personCount: personCount ?? this.personCount,
      keywordsCount: keywordsCount ?? this.keywordsCount,
      companyCount: companyCount ?? this.companyCount,
      uniqueKey: uniqueKey ?? this.uniqueKey,
    );
  }

  // Convert a MyClass instance to a Map
  Map<String, dynamic> toJson() => {
        'movieCount': movieCount,
        'tvShowsCount': tvShowsCount,
        'personCount': personCount,
        'keywordsCount': keywordsCount,
        'companyCount': companyCount,
        'uniqueKey': uniqueKey,
      };

  // Convert a Map to a MyClass instance
  factory CombineCountState.fromJson(Map<String, dynamic> json) => CombineCountState(
        movieCount: json['movieCount'],
        tvShowsCount: json['tvShowsCount'],
        personCount: json['personCount'],
        keywordsCount: json['keywordsCount'],
        companyCount: json['companyCount'],
        uniqueKey: json['uniqueKey'],
      );

  @override
  List<Object?> get props => [
        movieCount,
        tvShowsCount,
        personCount,
        keywordsCount,
        companyCount,
        uniqueKey,
      ];
}

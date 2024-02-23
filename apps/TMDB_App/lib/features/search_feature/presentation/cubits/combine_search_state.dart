import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_company_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_keywords_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_movie_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_tv_model.dart';

class CombineSearchState with EquatableMixin {
  final String query;
  final Map<String, List<Companies>> companies;
  final Map<String, List<Movies>> movies;
  final Map<String, List<TvShows>> tvShows;
  final Map<String, List<SearchKeywords>> searchKeywords;
  final Map<String, List<Persons>> persons;
  final CombineSearchStateStatus status;

  CombineSearchState({
    required this.query,
    required this.companies,
    required this.movies,
    required this.tvShows,
    required this.searchKeywords,
    required this.persons,
    required this.status,
  });

  factory CombineSearchState.initial() {
    return CombineSearchState(
      query: "",
      companies: {},
      movies: {},
      tvShows: {},
      searchKeywords: {},
      persons: {},
      status: CombineSearchStateNone(),
    );
  }

  CombineSearchState copyWith({
    String? query,
    Map<String, List<Companies>>? companies,
    Map<String, List<Movies>>? movies,
    Map<String, List<TvShows>>? tvShows,
    Map<String, List<SearchKeywords>>? searchKeywords,
    Map<String, List<Persons>>? persons,
    CombineSearchStateStatus? status,
  }) {
    return CombineSearchState(
      query: query ?? this.query,
      companies: companies ?? this.companies,
      movies: movies ?? this.movies,
      tvShows: tvShows ?? this.tvShows,
      searchKeywords: searchKeywords ?? this.searchKeywords,
      persons: persons ?? this.persons,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        query,
        companies,
        movies,
        tvShows,
        searchKeywords,
        persons,
        status,
      ];
}

sealed class CombineSearchStateStatus with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class CombineSearchStateNone extends CombineSearchStateStatus {}

class CombineSearchStateLoading extends CombineSearchStateStatus {}

class CombineSearchStateError extends CombineSearchStateStatus {
  final String error;

  CombineSearchStateError(this.error);

  @override
  List<Object?> get props => [error];
}

class CombineSearchStateSuccess extends CombineSearchStateStatus {}

class CombineSearchStateEmptyQuery extends CombineSearchStateStatus {}

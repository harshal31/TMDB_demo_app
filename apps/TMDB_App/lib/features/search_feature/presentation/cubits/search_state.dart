import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_company_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_keywords_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_movie_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_tv_model.dart';

class SearchState with EquatableMixin {
  final SearchCompaniesPaginationState searchCompaniesState;
  final SearchKeywordsPaginationState searchKeywordsState;
  final SearchMoviesPaginationState searchMoviesState;
  final SearchPersonsPaginationState searchPersonsState;
  final SearchTvShowsPaginationState searchTvShowsState;

  const SearchState({
    required this.searchCompaniesState,
    required this.searchKeywordsState,
    required this.searchMoviesState,
    required this.searchPersonsState,
    required this.searchTvShowsState,
  });

  factory SearchState.initial() {
    return SearchState(
      searchCompaniesState: SearchCompaniesPaginationNone(),
      searchKeywordsState: SearchKeywordsPaginationNone(),
      searchMoviesState: SearchMoviesPaginationNone(),
      searchPersonsState: SearchPersonsPaginationNone(),
      searchTvShowsState: SearchTvShowsPaginationNone(),
    );
  }

  SearchState copyWith({
    SearchCompaniesPaginationState? searchCompaniesState,
    SearchKeywordsPaginationState? searchKeywordsState,
    SearchMoviesPaginationState? searchMoviesState,
    SearchPersonsPaginationState? searchPersonsState,
    SearchTvShowsPaginationState? searchTvShowsState,
  }) {
    return SearchState(
      searchCompaniesState: searchCompaniesState ?? this.searchCompaniesState,
      searchKeywordsState: searchKeywordsState ?? this.searchKeywordsState,
      searchMoviesState: searchMoviesState ?? this.searchMoviesState,
      searchPersonsState: searchPersonsState ?? this.searchPersonsState,
      searchTvShowsState: searchTvShowsState ?? this.searchTvShowsState,
    );
  }

  bool get isMovieSearchState => (searchMoviesState is SearchMoviesPaginationNone ||
      searchMoviesState is SearchMoviesPaginationLoading ||
      searchMoviesState is SearchMoviesPaginationError ||
      searchMoviesState is SearchMoviesPaginationLoaded);

  bool get isTvShowsSearchState => (searchTvShowsState is SearchTvShowsPaginationNone ||
      searchTvShowsState is SearchTvShowsPaginationLoading ||
      searchTvShowsState is SearchTvShowsPaginationError ||
      searchTvShowsState is SearchTvShowsPaginationLoaded);

  bool get isSearchKeywordState => (searchKeywordsState is SearchKeywordsPaginationNone ||
      searchKeywordsState is SearchKeywordsPaginationLoading ||
      searchKeywordsState is SearchKeywordsPaginationError ||
      searchKeywordsState is SearchKeywordsPaginationLoaded);

  bool get isSearchCompaniesState => (searchCompaniesState is SearchCompaniesPaginationNone ||
      searchCompaniesState is SearchCompaniesPaginationLoading ||
      searchCompaniesState is SearchCompaniesPaginationError ||
      searchCompaniesState is SearchCompaniesPaginationLoaded);

  bool get isSearchPersonsState => (searchPersonsState is SearchPersonsPaginationNone ||
      searchPersonsState is SearchPersonsPaginationLoading ||
      searchPersonsState is SearchPersonsPaginationError ||
      searchPersonsState is SearchPersonsPaginationLoaded);

  @override
  List<Object?> get props => [
        searchCompaniesState,
        searchKeywordsState,
        searchMoviesState,
        searchPersonsState,
        searchTvShowsState,
      ];
}

sealed class SearchCompaniesPaginationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SearchCompaniesPaginationNone extends SearchCompaniesPaginationState {}

class SearchCompaniesPaginationLoading extends SearchCompaniesPaginationState {}

class SearchCompaniesPaginationLoaded extends SearchCompaniesPaginationState {
  final SearchCompanyModel model;
  final List<Companies> items;
  final bool hasReachedMax;

  SearchCompaniesPaginationLoaded({
    required this.model,
    required this.items,
    this.hasReachedMax = false,
  });

  bool get shouldDisplayPages => (this.model.totalResults ?? 0) > 20;

  @override
  List<Object?> get props => [model, items, hasReachedMax];
}

class SearchCompaniesPaginationError extends SearchCompaniesPaginationState {
  final String error;

  SearchCompaniesPaginationError(this.error);
}

sealed class SearchKeywordsPaginationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SearchKeywordsPaginationNone extends SearchKeywordsPaginationState {}

class SearchKeywordsPaginationLoading extends SearchKeywordsPaginationState {}

class SearchKeywordsPaginationLoaded extends SearchKeywordsPaginationState {
  final SearchKeywordsModel model;
  final List<SearchKeywords> items;
  final bool hasReachedMax;

  SearchKeywordsPaginationLoaded({
    required this.model,
    required this.items,
    this.hasReachedMax = false,
  });

  bool get shouldDisplayPages => (this.model.totalResults ?? 0) > 20;

  @override
  List<Object?> get props => [model, items, hasReachedMax];
}

class SearchKeywordsPaginationError extends SearchKeywordsPaginationState {
  final String error;

  SearchKeywordsPaginationError(this.error);
}

sealed class SearchMoviesPaginationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SearchMoviesPaginationNone extends SearchMoviesPaginationState {}

class SearchMoviesPaginationLoading extends SearchMoviesPaginationState {}

class SearchMoviesPaginationLoaded extends SearchMoviesPaginationState {
  final SearchMovieModel model;
  final List<Movies> items;
  final bool hasReachedMax;

  SearchMoviesPaginationLoaded({
    required this.model,
    required this.items,
    this.hasReachedMax = false,
  });

  bool get shouldDisplayPages => (this.model.totalResults ?? 0) > 20;

  @override
  List<Object?> get props => [model, items, hasReachedMax];
}

class SearchMoviesPaginationError extends SearchMoviesPaginationState {
  final String error;

  SearchMoviesPaginationError(this.error);
}

sealed class SearchPersonsPaginationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SearchPersonsPaginationNone extends SearchPersonsPaginationState {}

class SearchPersonsPaginationLoading extends SearchPersonsPaginationState {}

class SearchPersonsPaginationLoaded extends SearchPersonsPaginationState {
  final SearchPersonModel model;
  final List<Persons> items;
  final bool hasReachedMax;

  SearchPersonsPaginationLoaded({
    required this.model,
    required this.items,
    this.hasReachedMax = false,
  });

  bool get shouldDisplayPages => (this.model.totalResults ?? 0) > 20;

  @override
  List<Object?> get props => [model, items, hasReachedMax];
}

class SearchPersonsPaginationError extends SearchPersonsPaginationState {
  final String error;

  SearchPersonsPaginationError(this.error);
}

sealed class SearchTvShowsPaginationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SearchTvShowsPaginationNone extends SearchTvShowsPaginationState {}

class SearchTvShowsPaginationLoading extends SearchTvShowsPaginationState {}

class SearchTvShowsPaginationLoaded extends SearchTvShowsPaginationState {
  final SearchTvModel model;
  final List<TvShows> items;
  final bool hasReachedMax;

  SearchTvShowsPaginationLoaded({
    required this.model,
    required this.items,
    this.hasReachedMax = false,
  });

  bool get shouldDisplayPages => (this.model.totalResults ?? 0) > 20;

  @override
  List<Object?> get props => [model, items, hasReachedMax];
}

class SearchTvShowsPaginationError extends SearchTvShowsPaginationState {
  final String error;

  SearchTvShowsPaginationError(this.error);
}

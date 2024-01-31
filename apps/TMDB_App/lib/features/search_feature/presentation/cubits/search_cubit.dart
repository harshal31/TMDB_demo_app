import 'package:bloc/bloc.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/search_state.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_company_use_case.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_keywords_use_case%20copy.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_movies_use_case%20copy%203.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_persons_use_case%20copy%202.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/search_tv_shows_use_case%20copy%204.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchCompanyUseCase searchCompanyUseCase;
  final SearchKeywordsUseCase searchKeywordsUseCase;
  final SearchMoviesUseCase searchMoviesUseCase;
  final SearchPersonsUseCase searchPersonsUseCase;
  final SearchTvShowsUseCase searchTvShowsUseCase;
  final int _pageSize = 20;

  SearchCubit({
    required this.searchCompanyUseCase,
    required this.searchKeywordsUseCase,
    required this.searchMoviesUseCase,
    required this.searchPersonsUseCase,
    required this.searchTvShowsUseCase,
  }) : super(SearchState.initial());

  void searchMovies(String query, int page) async {
    if (state.searchMoviesState is SearchMoviesPaginationLoaded &&
        (state.searchMoviesState as SearchMoviesPaginationLoaded).hasReachedMax) {
      return;
    }

    if (page == 1) {
      emit(state.copyWith(searchMoviesState: SearchMoviesPaginationLoading()));
    }

    final movies = await searchMoviesUseCase.searchMovies(query, page);
    movies.fold(
      (l) {
        emit(
          state.copyWith(
            searchMoviesState: SearchMoviesPaginationError(l.errorMessage),
          ),
        );
      },
      (r) {
        final isLastPage = (r.movies?.length ?? 0) < _pageSize;
        final newList = (state.searchMoviesState is SearchMoviesPaginationLoaded)
            ? (state.searchMoviesState as SearchMoviesPaginationLoaded).items + (r.movies ?? [])
            : (r.movies ?? []);

        emit(
          state.copyWith(
            searchMoviesState: SearchMoviesPaginationLoaded(
              items: newList,
              hasReachedMax: isLastPage,
              model: r,
            ),
          ),
        );
      },
    );
  }

  void searchCompanies(String query, int page) async {
    if (state.searchCompaniesState is SearchCompaniesPaginationLoaded &&
        (state.searchCompaniesState as SearchCompaniesPaginationLoaded).hasReachedMax) {
      return;
    }

    if (page == 1) {
      emit(state.copyWith(searchCompaniesState: SearchCompaniesPaginationLoading()));
    }

    final companies = await searchCompanyUseCase.searchCompanies(query, page);
    companies.fold(
      (l) {
        emit(
          state.copyWith(
            searchCompaniesState: SearchCompaniesPaginationError(l.errorMessage),
          ),
        );
      },
      (r) {
        final isLastPage = (r.companies?.length ?? 0) < _pageSize;
        final newList = (state.searchCompaniesState is SearchCompaniesPaginationLoaded)
            ? (state.searchCompaniesState as SearchCompaniesPaginationLoaded).items +
                (r.companies ?? [])
            : (r.companies ?? []);

        emit(
          state.copyWith(
            searchCompaniesState: SearchCompaniesPaginationLoaded(
              items: newList,
              hasReachedMax: isLastPage,
              model: r,
            ),
          ),
        );
      },
    );
  }

  void searchTvShows(String query, int page) async {
    if (state.searchTvShowsState is SearchTvShowsPaginationLoaded &&
        (state.searchTvShowsState as SearchTvShowsPaginationLoaded).hasReachedMax) {
      return;
    }

    if (page == 1) {
      emit(state.copyWith(searchTvShowsState: SearchTvShowsPaginationLoading()));
    }

    final tvShows = await searchTvShowsUseCase.searchTvShows(query, page);
    tvShows.fold(
      (l) {
        emit(
          state.copyWith(
            searchTvShowsState: SearchTvShowsPaginationError(l.errorMessage),
          ),
        );
      },
      (r) {
        final isLastPage = (r.tvShows?.length ?? 0) < _pageSize;
        final newList = (state.searchCompaniesState is SearchTvShowsPaginationLoaded)
            ? (state.searchCompaniesState as SearchTvShowsPaginationLoaded).items +
                (r.tvShows ?? [])
            : (r.tvShows ?? []);

        emit(
          state.copyWith(
            searchTvShowsState: SearchTvShowsPaginationLoaded(
              items: newList,
              hasReachedMax: isLastPage,
              model: r,
            ),
          ),
        );
      },
    );
  }

  void searchKeywords(String query, int page) async {
    if (state.searchKeywordsState is SearchKeywordsPaginationLoaded &&
        (state.searchKeywordsState as SearchKeywordsPaginationLoaded).hasReachedMax) {
      return;
    }

    if (page == 1) {
      emit(state.copyWith(searchKeywordsState: SearchKeywordsPaginationLoading()));
    }

    final keywords = await searchKeywordsUseCase.searchKeywords(query, page);
    keywords.fold(
      (l) {
        emit(
          state.copyWith(
            searchKeywordsState: SearchKeywordsPaginationError(l.errorMessage),
          ),
        );
      },
      (r) {
        final isLastPage = (r.searchKeywords?.length ?? 0) < _pageSize;
        final newList = (state.searchKeywordsState is SearchKeywordsPaginationLoaded)
            ? (state.searchKeywordsState as SearchKeywordsPaginationLoaded).items +
                (r.searchKeywords ?? [])
            : (r.searchKeywords ?? []);

        emit(
          state.copyWith(
            searchKeywordsState: SearchKeywordsPaginationLoaded(
              items: newList,
              hasReachedMax: isLastPage,
              model: r,
            ),
          ),
        );
      },
    );
  }

  void searchPersons(String query, int page) async {
    if (state.searchPersonsState is SearchPersonsPaginationLoaded &&
        (state.searchPersonsState as SearchPersonsPaginationLoaded).hasReachedMax) {
      return;
    }

    if (page == 1) {
      emit(state.copyWith(searchPersonsState: SearchPersonsPaginationLoading()));
    }

    final persons = await searchPersonsUseCase.searchPersons(query, page);
    persons.fold(
      (l) {
        emit(
          state.copyWith(
            searchPersonsState: SearchPersonsPaginationError(l.errorMessage),
          ),
        );
      },
      (r) {
        final isLastPage = (r.persons?.length ?? 0) < _pageSize;
        final newList = (state.searchPersonsState is SearchPersonsPaginationLoaded)
            ? (state.searchPersonsState as SearchPersonsPaginationLoaded).items + (r.persons ?? [])
            : (r.persons ?? []);

        emit(
          state.copyWith(
            searchPersonsState: SearchPersonsPaginationLoaded(
              items: newList,
              hasReachedMax: isLastPage,
              model: r,
            ),
          ),
        );
      },
    );
  }
}

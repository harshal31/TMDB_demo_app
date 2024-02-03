import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_company_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_keywords_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_movie_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_tv_model.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/search_cubit.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/search_state.dart';
import 'package:tmdb_app/routes/route_param.dart';

class SearchManager {
  final PagingController<int, Movies> movieController = PagingController(firstPageKey: 1);
  final PagingController<int, TvShows> tvShowsController = PagingController(firstPageKey: 1);
  final PagingController<int, SearchKeywords> keywordsController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Persons> personsController = PagingController(firstPageKey: 1);
  final PagingController<int, Companies> companiesController = PagingController(firstPageKey: 1);
  late String searchType;

  void listenPaginationChanges(BuildContext context, String query) {
    searchType = GoRouter.of(context).routeInformationProvider.value.uri.path.split("/").last;

    if (searchType == RouteParam.movie) {
      _listenMoviesPaginationChanges(context.read(), query);
      return;
    }

    if (searchType == RouteParam.tv) {
      _listenTvShowsPaginationChanges(context.read(), query);
      return;
    }

    if (searchType == RouteParam.person) {
      _listenPersonsPaginationChanges(context.read(), query);
      return;
    }

    if (searchType == RouteParam.keyword) {
      _listenKeywordsPaginationChanges(context.read(), query);
      return;
    }

    if (searchType == RouteParam.company) {
      _listenCompanyPaginationChanges(context.read(), query);
      return;
    }
  }

  void _listenMoviesPaginationChanges(SearchCubit searchCubit, String query) {
    movieController.addPageRequestListener((pageKey) {
      searchCubit.searchMovies(query, pageKey);
    });

    searchCubit.stream.listen((state) {
      if (state.searchMoviesState is SearchMoviesPaginationLoaded) {
        final isLastPage = (state.searchMoviesState as SearchMoviesPaginationLoaded).hasReachedMax;
        if (isLastPage) {
          movieController.appendLastPage(
            (state.searchMoviesState as SearchMoviesPaginationLoaded).items,
          );
        } else {
          final nextPageKey = movieController.nextPageKey! + 1;
          movieController.appendPage(
            (state.searchMoviesState as SearchMoviesPaginationLoaded).items,
            nextPageKey,
          );
        }
      } else if (state.searchMoviesState is SearchMoviesPaginationError) {
        movieController.error = (state.searchMoviesState as SearchMoviesPaginationError).error;
      }
    });
  }

  void _listenTvShowsPaginationChanges(SearchCubit searchCubit, String query) {
    tvShowsController.addPageRequestListener((pageKey) {
      searchCubit.searchTvShows(query, pageKey);
    });

    searchCubit.stream.listen((state) {
      if (state.searchTvShowsState is SearchTvShowsPaginationLoaded) {
        final isLastPage =
            (state.searchTvShowsState as SearchTvShowsPaginationLoaded).hasReachedMax;
        if (isLastPage) {
          tvShowsController.appendLastPage(
            (state.searchTvShowsState as SearchTvShowsPaginationLoaded).items,
          );
        } else {
          final nextPageKey = tvShowsController.nextPageKey! + 1;
          tvShowsController.appendPage(
            (state.searchTvShowsState as SearchTvShowsPaginationLoaded).items,
            nextPageKey,
          );
        }
      } else if (state.searchTvShowsState is SearchTvShowsPaginationError) {
        tvShowsController.error = (state.searchTvShowsState as SearchTvShowsPaginationError).error;
      }
    });
  }

  void _listenPersonsPaginationChanges(SearchCubit searchCubit, String query) {
    personsController.addPageRequestListener((pageKey) {
      searchCubit.searchPersons(query, pageKey);
    });

    searchCubit.stream.listen((state) {
      if (state.searchPersonsState is SearchPersonsPaginationLoaded) {
        final isLastPage =
            (state.searchPersonsState as SearchPersonsPaginationLoaded).hasReachedMax;
        if (isLastPage) {
          personsController.appendLastPage(
            (state.searchPersonsState as SearchPersonsPaginationLoaded).items,
          );
        } else {
          final nextPageKey = personsController.nextPageKey! + 1;
          personsController.appendPage(
            (state.searchPersonsState as SearchPersonsPaginationLoaded).items,
            nextPageKey,
          );
        }
      } else if (state.searchPersonsState is SearchPersonsPaginationError) {
        personsController.error = (state.searchPersonsState as SearchPersonsPaginationError).error;
      }
    });
  }

  void _listenKeywordsPaginationChanges(SearchCubit searchCubit, String query) {
    keywordsController.addPageRequestListener((pageKey) {
      searchCubit.searchKeywords(query, pageKey);
    });

    searchCubit.stream.listen((state) {
      if (state.searchKeywordsState is SearchKeywordsPaginationLoaded) {
        final isLastPage =
            (state.searchKeywordsState as SearchKeywordsPaginationLoaded).hasReachedMax;
        if (isLastPage) {
          keywordsController.appendLastPage(
            (state.searchKeywordsState as SearchKeywordsPaginationLoaded).items,
          );
        } else {
          final nextPageKey = keywordsController.nextPageKey! + 1;
          keywordsController.appendPage(
            (state.searchKeywordsState as SearchKeywordsPaginationLoaded).items,
            nextPageKey,
          );
        }
      } else if (state.searchKeywordsState is SearchKeywordsPaginationError) {
        keywordsController.error =
            (state.searchKeywordsState as SearchKeywordsPaginationError).error;
      }
    });
  }

  void _listenCompanyPaginationChanges(SearchCubit searchCubit, String query) {
    companiesController.addPageRequestListener((pageKey) {
      searchCubit.searchCompanies(query, pageKey);
    });

    searchCubit.stream.listen((state) {
      if (state.searchCompaniesState is SearchCompaniesPaginationLoaded) {
        final isLastPage =
            (state.searchCompaniesState as SearchCompaniesPaginationLoaded).hasReachedMax;
        if (isLastPage) {
          companiesController.appendLastPage(
            (state.searchCompaniesState as SearchCompaniesPaginationLoaded).items,
          );
        } else {
          final nextPageKey = companiesController.nextPageKey! + 1;
          companiesController.appendPage(
            (state.searchCompaniesState as SearchCompaniesPaginationLoaded).items,
            nextPageKey,
          );
        }
      } else if (state.searchCompaniesState is SearchCompaniesPaginationError) {
        companiesController.error =
            (state.searchCompaniesState as SearchCompaniesPaginationError).error;
      }
    });
  }

  PagingController<int, dynamic> getController() {
    final index = getIndex(searchType);
    if (index == 0) {
      return movieController;
    }

    if (index == 1) {
      return tvShowsController;
    }

    if (index == 2) {
      return personsController;
    }

    if (index == 3) {
      return keywordsController;
    }

    if (index == 4) {
      return companiesController;
    }

    return movieController;
  }

  int getIndex(String searchType) {
    if (searchType == RouteParam.movie) {
      return 0;
    }
    if (searchType == RouteParam.tv) {
      return 1;
    }
    if (searchType == RouteParam.person) {
      return 2;
    }
    if (searchType == RouteParam.keyword) {
      return 3;
    }
    if (searchType == RouteParam.company) {
      return 4;
    }
    return 0;
  }

  String getSearchType(int index) {
    if (index == 0) {
      return RouteParam.movie;
    } else if (index == 1) {
      return RouteParam.tv;
    } else if (index == 2) {
      return RouteParam.person;
    } else if (index == 3) {
      return RouteParam.keyword;
    } else if (index == 4) {
      return RouteParam.company;
    } else {
      return RouteParam.movie;
    }
  }

  void disposeControllers() {
    movieController.dispose();
    tvShowsController.dispose();
    keywordsController.dispose();
    companiesController.dispose();
    personsController.dispose();
  }
}

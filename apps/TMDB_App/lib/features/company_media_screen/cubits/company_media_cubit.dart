import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/movies_advance_filter_use.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/tv_advance_filter_use_case.dart';

class CompanyMediaCubit extends Cubit<AdvanceFilterPaginationState> {
  final MoviesAdvanceFilterUseCase moviesAdvanceFilterUseCase;
  final TvAdvanceFilterUseCase tvAdvanceFilterUseCase;
  final int _pageSize = 20;

  CompanyMediaCubit(
    this.moviesAdvanceFilterUseCase,
    this.tvAdvanceFilterUseCase,
  ) : super(AdvanceFilterPaginationState.initial());

  void fetchKeywordMedias(String companyId, int page, bool isMovies) async {
    if (state.advancePaginationState is AdvanceFilterPaginationLoaded &&
        (state.advancePaginationState as AdvanceFilterPaginationLoaded).hasReachedMax) {
      return;
    }

    if (page == 1) {
      emit(state.copyWith(advancePaginationState: AdvanceFilterPaginationLoading()));
    }
    final results = await (isMovies
        ? moviesAdvanceFilterUseCase.advanceMovieFilter(withCompanies: companyId, page: page)
        : tvAdvanceFilterUseCase.advanceTvFilter(withCompanies: companyId, page: page));

    results.fold(
      (l) {
        emit(
          state.copyWith(
            advancePaginationState: AdvanceFilterPaginationError(l.errorMessage),
          ),
        );
      },
      (r) {
        final isLastPage = (r.latestData?.length ?? 0) < _pageSize;

        emit(
          state.copyWith(
            advancePaginationState: AdvanceFilterPaginationLoaded(
              r,
              r.latestData ?? [],
              isLastPage,
            ),
            totalResults: r.totalResults,
          ),
        );
      },
    );
  }

  void fetchPaginatedMedia(int page, bool isMovies) async {
    if (state.advancePaginationState is AdvanceFilterPaginationLoaded &&
        (state.advancePaginationState as AdvanceFilterPaginationLoaded).hasReachedMax) {
      return;
    }

    if (page == 1) {
      emit(state.copyWith(advancePaginationState: AdvanceFilterPaginationLoading()));
    }
    final results = await (isMovies
        ? moviesAdvanceFilterUseCase.advanceMovieFilter(page: page)
        : tvAdvanceFilterUseCase.advanceTvFilter(page: page));

    results.fold(
      (l) {
        emit(
          state.copyWith(
            advancePaginationState: AdvanceFilterPaginationError(l.errorMessage),
          ),
        );
      },
      (r) {
        final isLastPage = (r.latestData?.length ?? 0) < _pageSize;

        emit(
          state.copyWith(
            advancePaginationState: AdvanceFilterPaginationLoaded(
              r,
              r.latestData ?? [],
              isLastPage,
            ),
            totalResults: r.totalResults,
          ),
        );
      },
    );
  }
}

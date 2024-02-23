import 'package:bloc/bloc.dart';
import 'package:common_widgets/logger/log_manager.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/combine_search_state.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/combine_count_use_case.dart';

class CombineSearchResultCubit extends Cubit<CombineSearchState> {
  final CombineSearchResultUseCase _combineSearchResultUseCase;

  CombineSearchResultCubit(this._combineSearchResultUseCase) : super(CombineSearchState.initial());

  void consolidatedSearchResult(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(status: CombineSearchStateEmptyQuery()));
      return;
    }
    if (query == state.query) {
      Log.d("query $query is same hence not querying search");
      return;
    }

    emit(state.copyWith(status: CombineSearchStateLoading()));
    final result = await _combineSearchResultUseCase.consolidateSearchResults(query);

    result.fold(
      (l) {
        emit(
          state.copyWith(status: CombineSearchStateError(l.errorMessage)),
        );
      },
      (r) {
        emit(
          state.copyWith(
            query: query,
            movies: r.movies,
            tvShows: r.tvShows,
            persons: r.persons,
            searchKeywords: r.searchKeywords,
            companies: r.companies,
            status: CombineSearchStateSuccess(),
          ),
        );
      },
    );
  }
}

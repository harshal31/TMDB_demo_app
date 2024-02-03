import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:common_widgets/logger/log_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/data_storage/hive_manager.dart';
import 'package:tmdb_app/features/search_feature/presentation/cubits/combine_count_state.dart';
import 'package:tmdb_app/features/search_feature/presentation/use_case/combine_count_use_case.dart';

class CombineCountCubit extends Cubit<CombineCountState> {
  static String previousQuery = "";
  final CombineCountUseCase combineCountUseCase;

  CombineCountCubit(this.combineCountUseCase) : super(CombineCountState.initial());

  void fetchInitialCount(String query) async {
    final q = (await GetIt.instance.get<HiveManager>().getString(query)).split("|");

    if (previousQuery != query) {
      previousQuery = query;
      GetIt.instance.get<HiveManager>().delete(previousQuery);
    }

    if (q.first.isEmpty) {
      final result = await combineCountUseCase.fetchCountInitially(query);

      result.fold(
        (l) {
          Log.d("Unable to fetch search query initial count");
        },
        (r) {
          GetIt.instance.get<HiveManager>().putString(query, "$query|${jsonEncode(r.toJson())}");
          emit(
            state.copyWith(
              movieCount: r.movieCount,
              tvShowsCount: r.tvShowsCount,
              personCount: r.personCount,
              keywordsCount: r.keywordsCount,
              companyCount: r.companyCount,
            ),
          );
        },
      );
    } else {
      final save = CombineCountState.fromJson(jsonDecode(q[1]));
      emit(
        state.copyWith(
          movieCount: save.movieCount,
          tvShowsCount: save.tvShowsCount,
          personCount: save.personCount,
          keywordsCount: save.keywordsCount,
          companyCount: save.companyCount,
        ),
      );
    }
  }
}

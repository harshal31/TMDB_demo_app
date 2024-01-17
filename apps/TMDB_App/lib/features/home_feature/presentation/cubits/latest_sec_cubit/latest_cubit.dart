import 'package:common_widgets/widgets/code_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/latest_use_case.dart';

class LatestCubit extends Cubit<LatestState> {
  final LatestUseCase _latestUseCase;

  LatestCubit(this._latestUseCase) : super(LatestState.initial());

  void fetchLatestResults(bool switchState, String currentTabTitle) async {
    emit(state.copyWith(latestStatus: LatestSectionLoading(generateUniqueKey())));

    final mediaType = switchState ? ApiKey.movie : ApiKey.tv;
    final result = await _latestUseCase.fetchLatestResultsBasedOnMediaType(
      mediaType,
      currentTabTitle,
    );

    result.fold((l) {
      emit(state.copyWith(latestStatus: LatestSectionLoading(generateUniqueKey())));
    }, (r) {
      emit(state.copyWith(results: r, latestStatus: LatestSectionDone(generateUniqueKey())));
    });
  }
}

import 'package:common_widgets/widgets/code_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/latest_use_case.dart';

class LatestCubit extends Cubit<LatestState> {
  final LatestUseCase _latestUseCase;
  int latestApiCall = 0;

  LatestCubit(this._latestUseCase) : super(LatestState.initial());

  void fetchLatestResults(bool switchState, String currentTabTitle) async {
    emit(
      state.copyWith(
        latestStatus: LatestSectionLoading(generateUniqueKey()),
        error: null,
      ),
    );

    final mediaType = switchState ? ApiKey.movie : ApiKey.tv;
    final currentCall = ++latestApiCall;
    final result = await _latestUseCase.fetchLatestResultsBasedOnMediaType(
      mediaType,
      currentTabTitle,
    );

    result.fold((l) {
      if (currentCall == latestApiCall) {
        emit(
          state.copyWith(
            latestStatus: LatestSectionDone(generateUniqueKey()),
            error: l.errorMessage,
          ),
        );
      }
    }, (r) {
      if (currentCall == latestApiCall) {
        emit(
          state.copyWith(
            results: r,
            latestStatus: LatestSectionDone(generateUniqueKey()),
            error: null,
          ),
        );
      }
    });
  }
}

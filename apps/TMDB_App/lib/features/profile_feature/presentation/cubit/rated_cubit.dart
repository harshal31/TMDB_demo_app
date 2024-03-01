import 'package:tmdb_app/utils/code_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/constants/hive_key.dart';
import 'package:tmdb_app/data_storage/hive_manager.dart';
import 'package:tmdb_app/features/profile_feature/presentation/use_cases/account_media_use_case.dart';
import 'package:tmdb_app/features/profile_feature/presentation/use_cases/profile_use_case.dart';

class RatedCubit extends Cubit<AccountState> {
  final AccountMediaUseCase _useCase;

  RatedCubit(this._useCase) : super(AccountState.initial());

  void fetchAccountMedia({
    required Future<String> accountId,
    required String mediaType,
    required int pos,
  }) async {
    emit(state.copyWith(accountStatus: AccountLoading(generateUniqueKey()), pos: pos));
    final actId = await accountId;
    final sessionId = await GetIt.instance.get<HiveManager>().getString(HiveKey.sessionId);

    final result = await _useCase.fetchAccountMedia(actId, ApiKey.rated, mediaType, sessionId);

    result.fold((l) {
      emit(state.copyWith(accountStatus: AccountError(l.errorMessage), pos: pos));
    }, (r) {
      emit(state.copyWith(
          accountStatus: AccountDone(generateUniqueKey()), latestResults: r, pos: pos));
    });
  }
}
